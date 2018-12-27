package br.ufjf.pgcc.eseco.domain.service.experiment;

import br.ufjf.pgcc.eseco.domain.dao.experiment.DataProviderParameterDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.DataProviderParameter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class DataProviderParameterService {

    private final DataProviderParameterDAO dataProviderParameterDAO;

    @Autowired
    public DataProviderParameterService(DataProviderParameterDAO dataProviderParameterDAO) {
        this.dataProviderParameterDAO = dataProviderParameterDAO;
    }

    @Transactional
    public DataProviderParameter add(DataProviderParameter dataProviderParameter) throws Exception {
        return dataProviderParameterDAO.add(dataProviderParameter);
    }

    @Transactional
    public DataProviderParameter update(DataProviderParameter dataProviderParameter) throws Exception {
        return dataProviderParameterDAO.update(dataProviderParameter);
    }

    @Transactional
    public void delete(DataProviderParameter dataProviderParameter) throws Exception {
        dataProviderParameterDAO.delete(dataProviderParameter);
    }

    public DataProviderParameter find(int dataProviderParameterId) {
        return dataProviderParameterDAO.find(dataProviderParameterId);
    }

    public List<DataProviderParameter> findAll() {
        return dataProviderParameterDAO.findAll();
    }

}
