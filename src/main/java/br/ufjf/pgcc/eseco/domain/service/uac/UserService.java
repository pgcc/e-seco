package br.ufjf.pgcc.eseco.domain.service.uac;

import br.ufjf.pgcc.eseco.app.service.MailerService;
import br.ufjf.pgcc.eseco.domain.dao.uac.UserDAO;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.mail.MessagingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserService {

    private MailerService mailerService;
    private UserDAO userDao;

    @Autowired
    public UserService(UserDAO userDao, MailerService mailerService) {
        this.userDao = userDao;
        this.mailerService = mailerService;
    }


    @Transactional
    public User add(User user) {
        return userDao.add(user);
    }

    @Transactional(readOnly = true)
    public List<User> findAll() {
        return userDao.findAll();
    }

    @Transactional(readOnly = true)
    public List<User> findByEmail(String email) {
        if (email != null) {
            Map<String, String> map = new HashMap<String, String>();
            map.put("email", email);

            return userDao.findBy(map);
        } else {
            return null;
        }
    }

    @Transactional(readOnly = true)
    public User findByEmailAndPassword(String email, String password) {
        if (email != null && password != null) {
            Map<String, String> map = new HashMap<String, String>();
            map.put("email", email);
            map.put("password", DigestUtils.sha1Hex(password));

            return userDao.findOneBy(map);
        } else {
            return null;
        }
    }

    @Transactional
    public User registerNewUser(User user) throws MessagingException {



        String authentication_code = DigestUtils.sha1Hex("ae");
        String authentication_uri = "/register/" + authentication_code;
        String to = user.getEmail();
        String subject = "New Account Registration";
        String content = "" +
                "<p>Hi <strong>" + user.getName() + "</strong>!</p>" +
                "<br>" +
                "<p>Welcome to E-seco. In order to validate your new account, please, follow the link below:</p>" +
                "<br>" +
                "<br>" +
                "<a href='" + authentication_uri + "'>" + authentication_uri + "</a>" +
                "<br>"+
                "<br>"+
                "<p>E-Seco</p>";


        user.setLogin(user.getEmail());

        user = add(user);



        mailerService.sendMail(to, subject, content);


        return user;
    }
}