package br.ufjf.pgcc.eseco.domain.dao.uac;

import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import org.springframework.stereotype.Repository;

@Repository
public class UserDAO extends CommonDAO<User, Integer> {

    protected UserDAO() {
        super(User.class);
    }
}