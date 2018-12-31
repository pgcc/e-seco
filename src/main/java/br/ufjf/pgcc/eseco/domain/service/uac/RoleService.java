package br.ufjf.pgcc.eseco.domain.service.uac;

import br.ufjf.pgcc.eseco.domain.dao.uac.RoleDAO;
import br.ufjf.pgcc.eseco.domain.model.uac.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class RoleService {

    private final RoleDAO roleDAO;

    @Autowired
    public RoleService(RoleDAO roleDAO) {
        this.roleDAO = roleDAO;
    }

    @Transactional
    public Role find(int roleId) {
        return roleDAO.find(roleId);
    }

    @Transactional(readOnly = true)
    public List<Role> findAll() {
        return roleDAO.findAll();
    }

}
