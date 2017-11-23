package br.ufjf.pgcc.eseco.domain.service.core;

import br.ufjf.pgcc.eseco.domain.dao.core.ResearcherKeywordDAO;
import br.ufjf.pgcc.eseco.domain.model.core.Interest;
import br.ufjf.pgcc.eseco.domain.model.core.ResearcherKeyword;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ResearcherKeywordService {

    private final ResearcherKeywordDAO researcherKeywordDAO;

    @Autowired
    public ResearcherKeywordService(ResearcherKeywordDAO researcherKeywordDAO) {
        this.researcherKeywordDAO = researcherKeywordDAO;
    }

    @Transactional
    public ResearcherKeyword saveOrUpdate(ResearcherKeyword researcherKeyword) throws Exception {
        if (researcherKeyword.getId() == 0 || find(researcherKeyword.getId()) == null) {
            return researcherKeywordDAO.add(researcherKeyword);
        } else {
            return researcherKeywordDAO.update(researcherKeyword);
        }
    }

    public void delete(ResearcherKeyword researcherKeyword) throws Exception {
        researcherKeywordDAO.delete(researcherKeyword);
    }

    public ResearcherKeyword find(int researcherKeywordId) {
        return researcherKeywordDAO.find(researcherKeywordId);
    }

    public List<ResearcherKeyword> findAll() {
        return researcherKeywordDAO.findAll();
    }

}
