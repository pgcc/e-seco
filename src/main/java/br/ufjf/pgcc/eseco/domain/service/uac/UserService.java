package br.ufjf.pgcc.eseco.domain.service.uac;

import br.ufjf.pgcc.eseco.domain.dao.uac.UserDAO;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserService {

    private UserDAO userDao;

    @Autowired
    public UserService(UserDAO userDao) {
        this.userDao = userDao;
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
}