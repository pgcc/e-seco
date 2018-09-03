package br.ufjf.pgcc.eseco.domain.dao.experiment;

import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.DataProvider;
import org.springframework.stereotype.Repository;

@Repository
public class DataProviderDAO extends CommonDAO<DataProvider, Integer> {

    protected DataProviderDAO() {
        super(DataProvider.class);
    }
}
