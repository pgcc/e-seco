package br.ufjf.pgcc.eseco.domain.service.experiment;

import br.ufjf.pgcc.eseco.domain.dao.experiment.ExperimentDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.Experiment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class ExperimentService {

    private final ExperimentDAO experimentDAO;

    @Autowired
    public ExperimentService(ExperimentDAO experimentDAO) {
        this.experimentDAO = experimentDAO;
    }

    @Transactional
    public Experiment saveOrUpdate(Experiment experiment) throws Exception {
        if (experiment.getId() == 0 || find(experiment.getId()) == null) {
            return experimentDAO.add(experiment);
        } else {
            return experimentDAO.update(experiment);
        }
    }

    @Transactional
    public void delete(Experiment experiment) throws Exception {
        experimentDAO.delete(experiment);
    }

    public Experiment find(int experimentId) {
        return experimentDAO.find(experimentId);
    }

    public List<Experiment> findAll() {
        return experimentDAO.findAll();
    }

}
