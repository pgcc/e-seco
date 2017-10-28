package br.ufjf.pgcc.eseco.domain.dao.core;

import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import br.ufjf.pgcc.eseco.domain.model.core.ResearchGroup;
import org.springframework.stereotype.Repository;

@Repository
public class ResearchGroupDAO extends CommonDAO<ResearchGroup, Integer> {

    protected ResearchGroupDAO() {
        super(ResearchGroup.class);
    }
}