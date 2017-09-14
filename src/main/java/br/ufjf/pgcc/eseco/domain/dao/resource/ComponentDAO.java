package br.ufjf.pgcc.eseco.domain.dao.resource;

import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import br.ufjf.pgcc.eseco.domain.model.resource.Component;
import org.springframework.stereotype.Repository;

@Repository
public class ComponentDAO extends CommonDAO<Component, Integer> {

    protected ComponentDAO() {
        super(Component.class);
    }
}