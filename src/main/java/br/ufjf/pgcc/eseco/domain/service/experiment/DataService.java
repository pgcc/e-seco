package br.ufjf.pgcc.eseco.domain.service.experiment;

import br.ufjf.pgcc.eseco.domain.dao.experiment.DataDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class DataService {

    private final DataDAO dataDAO;

    @Autowired
    public DataService(DataDAO dataDAO) {
        this.dataDAO = dataDAO;
    }

    @Transactional
    public Data saveOrUpdate(Data data) throws Exception {
        if (data.getId() == 0 || find(data.getId()) == null) {
            return dataDAO.add(data);
        } else {
            return dataDAO.update(data);
        }
    }

    @Transactional
    public void delete(Data data) throws Exception {
        dataDAO.delete(data);
    }

    public Data find(int dataId) {
        return dataDAO.find(dataId);
    }

    public List<Data> findAll() {
        return dataDAO.findAll();
    }

}
