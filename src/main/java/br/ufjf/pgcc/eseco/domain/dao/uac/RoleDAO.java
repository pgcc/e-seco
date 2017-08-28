package br.ufjf.pgcc.eseco.domain.dao.uac;

import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import br.ufjf.pgcc.eseco.domain.model.uac.Role;
import org.springframework.stereotype.Repository;

@Repository
public class RoleDAO extends CommonDAO<Role, Integer> {

    protected RoleDAO() {
        super(Role.class);
    }
}