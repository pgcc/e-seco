package br.ufjf.pgcc.eseco.domain.service.experiment;

import br.ufjf.pgcc.eseco.domain.dao.experiment.DataSourceDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.DataSource;
import br.ufjf.pgcc.eseco.domain.model.experiment.DataSourceProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class DataSourceService {

    private final DataSourceDAO dataSourceDAO;
    private final DataSourceProviderService dataSourceProviderService;

    @Autowired
    public DataSourceService(
            DataSourceDAO dataSourceDAO,
            DataSourceProviderService dataSourceProviderService) {
        this.dataSourceDAO = dataSourceDAO;
        this.dataSourceProviderService = dataSourceProviderService;
    }

    @Transactional
    public DataSource add(DataSource dataSource) throws Exception {
        List<DataSourceProvider> dataSourceProviderList = dataSource.getProviders();
        dataSource = dataSourceDAO.add(dataSource);

        for (DataSourceProvider dataSourceProvider : dataSourceProviderList) {
            dataSourceProvider.setDataSource(dataSource);
            dataSourceProviderService.add(dataSourceProvider);
        }

        return dataSource;
    }

    @Transactional
    public DataSource update(DataSource dataSource) throws Exception {
        return dataSourceDAO.update(dataSource);
    }

    @Transactional
    public void delete(DataSource dataSource) throws Exception {
        dataSourceDAO.delete(dataSource);
    }

    public DataSource find(int dataSourceId) {
        return dataSourceDAO.find(dataSourceId);
    }

    public List<DataSource> findAll() {
        return dataSourceDAO.findAll();
    }

}
