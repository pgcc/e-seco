package br.ufjf.pgcc.eseco.domain.dao.core;

import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import org.springframework.stereotype.Repository;

@Repository
public class ResearcherDAO extends CommonDAO<Researcher, Long> {

    protected ResearcherDAO() {
        super(Researcher.class);
    }
}