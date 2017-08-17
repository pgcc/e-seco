package br.ufjf.pgcc.eseco.domain.dao.core;

import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import br.ufjf.pgcc.eseco.domain.model.core.Developer;
import org.springframework.stereotype.Repository;

@Repository
public class DeveloperDAO extends CommonDAO<Developer, Integer> {

    protected DeveloperDAO() {
        super(Developer.class);
    }
}