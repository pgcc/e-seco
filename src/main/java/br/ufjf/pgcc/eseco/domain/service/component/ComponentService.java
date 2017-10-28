package br.ufjf.pgcc.eseco.domain.service.component;

import br.ufjf.pgcc.eseco.domain.dao.resource.ComponentDAO;
import br.ufjf.pgcc.eseco.domain.model.resource.Component;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ComponentService {

    private ComponentDAO componentDao;

    @Autowired
    public ComponentService(ComponentDAO componentDao) {
        this.componentDao = componentDao;
    }

    @Transactional
    public Component add(Component component) throws Exception{
        return componentDao.add(component);
    }

    public Component find(int componentId) {
        return componentDao.find(componentId);
    }

    public List<Component> findAll() {
        return componentDao.findAll();
    }
}