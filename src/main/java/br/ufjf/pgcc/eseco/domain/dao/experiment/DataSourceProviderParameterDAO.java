package br.ufjf.pgcc.eseco.domain.dao.experiment;

import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.DataSourceProviderParameter;
import org.springframework.stereotype.Repository;

@Repository
public class DataSourceProviderParameterDAO extends CommonDAO<DataSourceProviderParameter, Integer> {

    protected DataSourceProviderParameterDAO() {
        super(DataSourceProviderParameter.class);
    }
}
