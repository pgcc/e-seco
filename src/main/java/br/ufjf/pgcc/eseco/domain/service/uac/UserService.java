package br.ufjf.pgcc.eseco.domain.service.uac;

import br.ufjf.pgcc.eseco.app.service.MailerService;
import br.ufjf.pgcc.eseco.domain.dao.uac.UserDAO;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class UserService {

    private MailerService mailerService;
    private UserDAO userDao;

    @Autowired
    public UserService(UserDAO userDao, MailerService mailerService) {
        this.userDao = userDao;
        this.mailerService = mailerService;
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
    public User registerNewUser(User user) throws Exception {
        // Define new user data
        Date date_today = new Date();

        // Get tomorrow date
        Calendar c = Calendar.getInstance();
        c.setTime(date_today);
        c.add(Calendar.DATE, 1);
        Date date_tomorrow = c.getTime();
        DateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        String formatted_date_tomorrow = df.format(date_tomorrow);

        // Create authentication code
        String authentication_code = DigestUtils.sha1Hex(date_tomorrow + "u" + user.getEmail());
        // @TODO: Get the actual url, instead of localhost:8888
        String authentication_uri = "http://localhost:8888/eseco/register/" + authentication_code;

        // Set new user data
        user.setActive(false);
        user.setLogin(user.getEmail());
        user.setRegisterDate(date_today);
        user.setActivationCode(authentication_code);
        user.setActivationExpireDate(date_tomorrow);

        user = userDao.add(user);

        // Set register instructions e-mail content
        String to = user.getEmail();
        String subject = "New Account Registration";
        // @TODO: Remove the hardcoded content by retrieving it from a .jsp file
        String content = "" +
                "<p>Hi <strong>" + user.getName() + "</strong>!</p>" +
                "<br>" +
                "<p>Welcome to E-seco. In order to validate your new account, please, follow the link below:</p>" +
                "<br>" +
                "<p><a href='" + authentication_uri + "'>" + authentication_uri + "</a></p>" +
                "<br>" +
                "<p>This link will be active until: " + formatted_date_tomorrow + "</p>" +
                "<br>" +
                "<br>" +
                "<p>E-Seco</p>";

        // Send register instructions e-mail
        mailerService.sendMail(to, subject, content);

        return user;
    }

    @Transactional
    public User activateUser(User user, String password) throws Exception {
        user.setPassword(DigestUtils.sha1Hex(password));
        user.setActivationCode(null);
        user.setActivationExpireDate(null);
        user.setActive(true);

        user = userDao.update(user);

        return user;
    }
}