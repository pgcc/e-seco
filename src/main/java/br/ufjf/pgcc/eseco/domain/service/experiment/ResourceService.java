package br.ufjf.pgcc.eseco.domain.service.experiment;

import br.ufjf.pgcc.eseco.domain.dao.experiment.ResourceDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ResourceService {

    private ResourceDAO resourceDao;

    @Autowired
    public ResourceService(ResourceDAO resourceDao) {
        this.resourceDao = resourceDao;
    }

    @Transactional
    public Resource add(Resource resource) throws Exception{
        return resourceDao.add(resource);
    }

    @Transactional(readOnly = true)
    public List<Resource> findAll() {
        return resourceDao.findAll();
    }
}