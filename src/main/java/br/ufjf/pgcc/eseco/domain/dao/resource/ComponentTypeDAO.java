package br.ufjf.pgcc.eseco.domain.dao.resource;

import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import br.ufjf.pgcc.eseco.domain.model.resource.ComponentType;
import org.springframework.stereotype.Repository;

@Repository
public class ComponentTypeDAO extends CommonDAO<ComponentType, Integer> {

    protected ComponentTypeDAO() {
        super(ComponentType.class);
    }
}