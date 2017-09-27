package br.ufjf.pgcc.eseco.domain.service.experiment;

import br.ufjf.pgcc.eseco.domain.dao.experiment.EntityDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.Entity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class EntityService {

    private final EntityDAO entityDAO;

    @Autowired
    public EntityService(EntityDAO entityDAO) {
        this.entityDAO = entityDAO;
    }

    @Transactional
    public Entity saveOrUpdate(Entity entity) throws Exception {
        if (entity.getId() == 0 || find(entity.getId()) == null) {
            return entityDAO.add(entity);
        } else {
            return entityDAO.update(entity);
        }
    }

    @Transactional
    public void delete(Entity entity) throws Exception {
        entityDAO.delete(entity);
    }

    public Entity find(int entityId) {
        return entityDAO.find(entityId);
    }

    public List<Entity> findAll() {
        return entityDAO.findAll();
    }

}
