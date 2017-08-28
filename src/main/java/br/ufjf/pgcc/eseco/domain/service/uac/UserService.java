package br.ufjf.pgcc.eseco.domain.service.uac;

import br.ufjf.pgcc.eseco.app.service.MailerService;
import br.ufjf.pgcc.eseco.domain.dao.uac.UserDAO;
import br.ufjf.pgcc.eseco.domain.model.core.Agent;
import br.ufjf.pgcc.eseco.domain.model.uac.Role;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.core.AgentService;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class UserService {

    private UserDAO userDao;
    private MailerService mailerService;
    private AgentService agentService;
    private RoleService roleService;

    @Autowired
    public UserService(UserDAO userDao, MailerService mailerService, AgentService agentService, RoleService roleService) {
        this.userDao = userDao;
        this.mailerService = mailerService;
        this.agentService = agentService;
        this.roleService = roleService;
    }

    public UserService() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Transactional
    public User find(int userId) {
        return userDao.find(userId);
    }

    @Transactional(readOnly = true)
    public List<User> findAll() {
        return userDao.findAll();
    }

    @Transactional(readOnly = true)
    public List<User> findByEmail(String email) {
        if (email != null) {
            Map<String, String> map = new HashMap<>();
            map.put("email", email);

            return userDao.findBy(map);
        } else {
            return null;
        }
    }

    @Transactional(readOnly = true)
    public User findByEmailAndPassword(String email, String password) {
        if (email != null && password != null) {
            Map<String, String> map = new HashMap<>();
            map.put("email", email);
            map.put("password", DigestUtils.sha1Hex(password));

            return userDao.findOneBy(map);
        } else {
            return null;
        }
    }

    @Transactional(readOnly = true)
    public User findByActivationCode(String activationCode) {
        if (activationCode != null) {
            Map<String, String> map = new HashMap<>();
            map.put("activationCode", activationCode);

            User user = userDao.findOneBy(map);

            // Check if the activation date is not expired
            Date date_today = new Date();
            if (date_today.before(user.getActivationExpireDate())) {
                return user;
            } else {
                return null;
            }

        } else {
            return null;
        }
    }

    @Transactional
    public User registerNewUser(String email, String name) throws Exception {
        // Instantiate the new User and his respective Agent (every User has an Agent linked to him)
        User new_user = new User();
        Agent new_user_agent = new Agent();

        // Get today date
        Date date_today = new Date();

        // Get tomorrow date
        Calendar c = Calendar.getInstance();
        c.setTime(date_today);
        c.add(Calendar.DATE, 1);
        Date date_tomorrow = c.getTime();
        DateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        String formatted_date_tomorrow = df.format(date_tomorrow);

        // Create authentication code
        String authentication_code = DigestUtils.sha1Hex(date_tomorrow + "u" + new_user.getEmail());
        // @TODO: Get the actual url, instead of localhost:8888
        String authentication_uri = "http://localhost:8888/eseco/register/" + authentication_code;

        // Set new user data
        new_user.setActive(false);
        new_user.setEmail(email);
        new_user.setLogin(email);
        new_user.setRegisterDate(date_today);
        new_user.setActivationCode(authentication_code);
        new_user.setActivationExpireDate(date_tomorrow);

        // Add new user
        new_user = userDao.add(new_user);

        // Define new user agent data
        new_user_agent.setName(name);
        new_user_agent.setUser(new_user);

        // Add new user agent
        new_user_agent = agentService.registerNewAgent(new_user_agent);

        // Set user agent to user
        new_user.setAgent(new_user_agent);

        // Set register instructions e-mail content
        String to = new_user.getEmail();
        String subject = "New Account Registration";
        // @TODO: Remove the hardcoded content by retrieving it from a .jsp file
        String content = ""
                + "<p>Hi <strong>" + new_user.getAgent().getName() + "</strong>!</p>"
                + "<br>"
                + "<p>Welcome to E-seco. In order to validate your new account, please, follow the link below:</p>"
                + "<br>"
                + "<p><a href='" + authentication_uri + "'>" + authentication_uri + "</a></p>"
                + "<br>"
                + "<p>This link will be active until: " + formatted_date_tomorrow + "</p>"
                + "<br>"
                + "<br>"
                + "<p>E-Seco</p>";

        // Send register instructions e-mail
        mailerService.sendMail(to, subject, content);

        return new_user;
    }

    @Transactional
    public User activateUser(User user, String password, List<Integer> rolesIdList) throws Exception {
        // Get the Roles from roles id list
        ArrayList<Role> rolesList = new ArrayList<>();
        for (Integer roleId : rolesIdList) {
            rolesList.add(roleService.find(roleId));
        }

        // Set user data
        user.setPassword(DigestUtils.sha1Hex(password));
        user.setActivationCode(null);
        user.setActivationExpireDate(null);
        user.setActive(true);
        user.setRoles(rolesList);

        // Update user
        user = userDao.update(user);

        return user;
    }

    @Transactional
    public User startUserRecovery(User user) {
        // @TODO: Implement user recovery process
        return user;
    }

    public User saveOrUpdate(User user) throws Exception {
        if (user.getId() == 0 || find(user.getId()) == null) {
            return userDao.add(user);
        } else {
            return userDao.update(user);
        }
    }
}
