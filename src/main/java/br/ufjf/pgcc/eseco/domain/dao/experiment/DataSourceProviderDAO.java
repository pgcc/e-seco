package br.ufjf.pgcc.eseco.domain.dao.experiment;

import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.DataSourceProvider;
import org.springframework.stereotype.Repository;

@Repository
public class DataSourceProviderDAO extends CommonDAO<DataSourceProvider, Integer> {

    protected DataSourceProviderDAO() {
        super(DataSourceProvider.class);
    }
}
