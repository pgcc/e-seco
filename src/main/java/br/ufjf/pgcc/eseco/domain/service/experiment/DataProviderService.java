package br.ufjf.pgcc.eseco.domain.service.experiment;

import br.ufjf.pgcc.eseco.domain.dao.experiment.DataProviderDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.DataProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class DataProviderService {

    private final DataProviderDAO dataProviderDAO;

    @Autowired
    public DataProviderService(DataProviderDAO dataProviderDAO) {
        this.dataProviderDAO = dataProviderDAO;
    }

    @Transactional
    public DataProvider add(DataProvider dataProvider) throws Exception {
        return dataProviderDAO.add(dataProvider);
    }

    @Transactional
    public DataProvider update(DataProvider dataProvider) throws Exception {
        return dataProviderDAO.update(dataProvider);
    }

    @Transactional
    public void delete(DataProvider dataProvider) throws Exception {
        dataProviderDAO.delete(dataProvider);
    }

    public DataProvider find(int dataProviderId) {
        return dataProviderDAO.find(dataProviderId);
    }

    public List<DataProvider> findAll() {
        return dataProviderDAO.findAll();
    }

}
