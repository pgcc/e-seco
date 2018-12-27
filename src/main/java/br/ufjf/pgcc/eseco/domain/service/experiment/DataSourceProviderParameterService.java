package br.ufjf.pgcc.eseco.domain.service.experiment;

import br.ufjf.pgcc.eseco.domain.dao.experiment.DataSourceProviderParameterDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.DataSourceProviderParameter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class DataSourceProviderParameterService {

    private final DataSourceProviderParameterDAO dataSourceProviderParameterDAO;

    @Autowired
    public DataSourceProviderParameterService(DataSourceProviderParameterDAO dataSourceProviderParameterDAO) {
        this.dataSourceProviderParameterDAO = dataSourceProviderParameterDAO;
    }

    @Transactional
    public DataSourceProviderParameter add(DataSourceProviderParameter dataSourceProviderParameter) throws Exception {
        return dataSourceProviderParameterDAO.add(dataSourceProviderParameter);
    }

    @Transactional
    public DataSourceProviderParameter update(DataSourceProviderParameter dataSourceProviderParameter) throws Exception {
        return dataSourceProviderParameterDAO.update(dataSourceProviderParameter);
    }

    @Transactional
    public void delete(DataSourceProviderParameter dataSourceProviderParameter) throws Exception {
        dataSourceProviderParameterDAO.delete(dataSourceProviderParameter);
    }

    public DataSourceProviderParameter find(int dataSourceProviderParameterId) {
        return dataSourceProviderParameterDAO.find(dataSourceProviderParameterId);
    }

    public List<DataSourceProviderParameter> findAll() {
        return dataSourceProviderParameterDAO.findAll();
    }

}
