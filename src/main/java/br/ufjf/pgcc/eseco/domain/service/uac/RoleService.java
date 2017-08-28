package br.ufjf.pgcc.eseco.domain.service.uac;

import br.ufjf.pgcc.eseco.domain.dao.uac.RoleDAO;
import br.ufjf.pgcc.eseco.domain.model.uac.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

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

    @Transactional
    public void populateRoles() {
        if (roleDAO.findAll().isEmpty()) {
            try {
                roleDAO.add(new Role(1, "Admin"));
                roleDAO.add(new Role(2, "Researcher"));
                roleDAO.add(new Role(3, "Developer"));
            } catch (Exception ex) {
                Logger.getLogger(RoleService.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
