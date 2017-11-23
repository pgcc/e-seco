package br.ufjf.pgcc.eseco.domain.dao.core;

import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import br.ufjf.pgcc.eseco.domain.model.core.ResearcherKeyword;
import org.springframework.stereotype.Repository;


@Repository
public class ResearcherKeywordDAO extends CommonDAO<ResearcherKeyword, Integer> {

    protected ResearcherKeywordDAO() {
        super(ResearcherKeyword.class);
    }
}