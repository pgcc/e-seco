package br.ufjf.pgcc.eseco.domain.dao.experiment;

import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.DataSource;
import org.springframework.stereotype.Repository;

@Repository
public class DataSourceDAO extends CommonDAO<DataSource, Integer> {

    protected DataSourceDAO() {
        super(DataSource.class);
    }
}
