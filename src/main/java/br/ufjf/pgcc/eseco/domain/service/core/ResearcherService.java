package br.ufjf.pgcc.eseco.domain.service.core;

import br.ufjf.pgcc.eseco.domain.dao.core.ResearcherDAO;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class ResearcherService {

    private ResearcherDAO researcherDao;

    @Autowired
    public ResearcherService(ResearcherDAO researcherDao) {
        this.researcherDao = researcherDao;
    }


    @Transactional(readOnly = true)
    public List<Researcher> findAll() {
        return researcherDao.findAll();
    }

    @Transactional
    public Researcher registerNewResearcher(Researcher researcher) {

        researcher = researcherDao.add(researcher);

        return researcher;
    }
}