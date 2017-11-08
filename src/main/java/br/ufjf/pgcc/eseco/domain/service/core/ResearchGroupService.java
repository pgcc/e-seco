package br.ufjf.pgcc.eseco.domain.service.core;

import br.ufjf.pgcc.eseco.domain.dao.core.ResearchGroupDAO;
import br.ufjf.pgcc.eseco.domain.model.core.Institution;
import br.ufjf.pgcc.eseco.domain.model.core.ResearchGroup;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ResearchGroupService {

    private ResearchGroupDAO researchGroupDao;

    @Autowired
    public ResearchGroupService(ResearchGroupDAO researchGroupDao) {
        this.researchGroupDao = researchGroupDao;
    }

    public ResearchGroup find(int researchGroupId) {
        return researchGroupDao.find(researchGroupId);
    }

    public List<ResearchGroup> findAll() {
        return researchGroupDao.findAll();
    }

    @Transactional
    public void delete(ResearchGroup researchGroup) throws Exception {
        researchGroupDao.delete(researchGroup);
    }
    
    @Transactional
    public ResearchGroup saveOrUpdate(ResearchGroup researchGroup) throws Exception {
        if (researchGroup.getId() == 0 || find(researchGroup.getId()) == null) {
            return researchGroupDao.add(researchGroup);
        } else {
            return researchGroupDao.update(researchGroup);
        }
    }

    @Transactional
    public ResearchGroup registerNewResearchGroup(ResearchGroup researchGroup) throws Exception {
        return researchGroupDao.add(researchGroup);
    }

    @Transactional
    public ResearchGroup updateResearchGroup(ResearchGroup researchGroup) throws Exception {
        return researchGroupDao.update(researchGroup);
    }
}