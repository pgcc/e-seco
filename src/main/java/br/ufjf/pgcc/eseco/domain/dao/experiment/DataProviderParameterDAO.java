package br.ufjf.pgcc.eseco.domain.dao.experiment;

import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.DataProviderParameter;
import org.springframework.stereotype.Repository;

@Repository
public class DataProviderParameterDAO extends CommonDAO<DataProviderParameter, Integer> {

    protected DataProviderParameterDAO() {
        super(DataProviderParameter.class);
    }
}
