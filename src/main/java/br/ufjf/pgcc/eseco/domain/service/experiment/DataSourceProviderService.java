package br.ufjf.pgcc.eseco.domain.service.experiment;

import br.ufjf.pgcc.eseco.domain.dao.experiment.DataSourceProviderDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.DataSourceProvider;
import br.ufjf.pgcc.eseco.domain.model.experiment.DataSourceProviderParameter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class DataSourceProviderService {

    private final DataSourceProviderDAO dataSourceProviderDAO;
    private final DataSourceProviderParameterService dataSourceProviderParameterService;

    @Autowired
    public DataSourceProviderService(
            DataSourceProviderDAO dataSourceProviderDAO,
            DataSourceProviderParameterService dataSourceProviderParameterService
    ) {
        this.dataSourceProviderDAO = dataSourceProviderDAO;
        this.dataSourceProviderParameterService = dataSourceProviderParameterService;
    }

    @Transactional
    public DataSourceProvider add(DataSourceProvider dataSourceProvider) throws Exception {
        List<DataSourceProviderParameter> dataSourceProviderParameterList = dataSourceProvider.getParameters();
        dataSourceProvider = dataSourceProviderDAO.add(dataSourceProvider);

        for (DataSourceProviderParameter dataSourceProviderParameter : dataSourceProviderParameterList) {
            dataSourceProviderParameter.setDataSourceProvider(dataSourceProvider);
            dataSourceProviderParameterService.add(dataSourceProviderParameter);
        }

        return dataSourceProvider;
    }

    @Transactional
    public DataSourceProvider update(DataSourceProvider dataSourceProvider) throws Exception {
        return dataSourceProviderDAO.update(dataSourceProvider);
    }

    @Transactional
    public void delete(DataSourceProvider dataSourceProvider) throws Exception {
        dataSourceProviderDAO.delete(dataSourceProvider);
    }

    public DataSourceProvider find(int dataSourceProviderId) {
        return dataSourceProviderDAO.find(dataSourceProviderId);
    }

    public List<DataSourceProvider> findAll() {
        return dataSourceProviderDAO.findAll();
    }

}
