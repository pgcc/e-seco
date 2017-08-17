package br.ufjf.pgcc.eseco.domain.dao.experiment;

import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.Resource;
import org.springframework.stereotype.Repository;

@Repository
public class ResourceDAO extends CommonDAO<Resource, Integer> {

    protected ResourceDAO() {
        super(Resource.class);
    }
}