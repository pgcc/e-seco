package br.ufjf.pgcc.eseco.domain.service.core;

import br.ufjf.pgcc.eseco.domain.dao.core.DeveloperDAO;
import br.ufjf.pgcc.eseco.domain.model.core.Developer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class DeveloperService {

    private DeveloperDAO developerDao;

    @Autowired
    public DeveloperService(DeveloperDAO developerDao) {
        this.developerDao = developerDao;
    }


    @Transactional(readOnly = true)
    public List<Developer> findAll() {
        return developerDao.findAll();
    }

    @Transactional
    public Developer registerNewDeveloper(Developer developer) throws Exception {

        developer = developerDao.add(developer);

        return developer;
    }
}