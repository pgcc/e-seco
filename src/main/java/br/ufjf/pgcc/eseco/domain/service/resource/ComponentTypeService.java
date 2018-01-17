package br.ufjf.pgcc.eseco.domain.service.resource;

import br.ufjf.pgcc.eseco.domain.dao.resource.ComponentTypeDAO;
import br.ufjf.pgcc.eseco.domain.model.resource.ComponentType;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowServiceComment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ComponentTypeService {

    private ComponentTypeDAO componentTypeDao;

    @Autowired
    public ComponentTypeService(ComponentTypeDAO componentTypeDao) {
        this.componentTypeDao = componentTypeDao;
    }

    @Transactional
    public ComponentType add(ComponentType componentType) throws Exception {
        return componentTypeDao.add(componentType);
    }

    public ComponentType find(int componentTypeId) {
        return componentTypeDao.find(componentTypeId);
    }

    @Transactional(readOnly = true)
    public List<ComponentType> findAll() {
        return componentTypeDao.findAll();
    }

    @Transactional
    public void populateComponentTypes() throws Exception {
        if (componentTypeDao.findAll().isEmpty()) {
            componentTypeDao.add(new ComponentType("Plugin"));
            componentTypeDao.add(new ComponentType("Workflow Service"));
        }
    }
}