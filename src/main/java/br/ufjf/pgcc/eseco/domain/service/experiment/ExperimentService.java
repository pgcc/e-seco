package br.ufjf.pgcc.eseco.domain.service.experiment;

import br.ufjf.pgcc.eseco.domain.dao.experiment.ExperimentDAO;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import br.ufjf.pgcc.eseco.domain.model.experiment.Experiment;
import br.ufjf.pgcc.eseco.domain.model.experiment.ExperimentPhase;
import br.ufjf.pgcc.eseco.domain.model.experiment.Workflow;
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

    public List<Experiment> findByWorkflowId(int workflowID) {

        List<Experiment> experiments = findAll();
        ArrayList<Experiment> experimentsFound = new ArrayList<>();

        for (Experiment experiment : experiments) {
            for (Workflow workflow : experiment.getWorkflows()) {
                if (workflow.getId() == workflowID) {
                    if (!experimentsFound.contains(experiment)) {
                        experimentsFound.add(experiment);
                    }
                }
            }
        }

        return experimentsFound;
    }

    public List<Experiment> findByResearcherId(int researcherID) {

        List<Experiment> experiments = findAll();
        ArrayList<Experiment> experimentsFound = new ArrayList<>();

        for (Experiment experiment : experiments) {
            if (experiment.getAuthor().getId() == researcherID) {
                if (!experimentsFound.contains(experiment)) {
                    experimentsFound.add(experiment);
                }
            } else {
                for (Researcher researcher : experiment.getResearchers()) {
                    if (researcher.getId() == researcherID) {
                        if (!experimentsFound.contains(experiment)) {
                            experimentsFound.add(experiment);
                        }
                    }
                }
            }
        }
        return experimentsFound;
    }

    /**
     *
     * @param experimentPhase
     * @return
     */
    public List<Experiment> findByPhase(ExperimentPhase experimentPhase) {

        List<Experiment> experiments = findAll();
        ArrayList<Experiment> experimentsFound = new ArrayList<>();

        for (Experiment experiment : experiments) {
            if (experiment.getCurrentPhase() == experimentPhase) {
                if (!experimentsFound.contains(experiment)) {
                    experimentsFound.add(experiment);
                }
            }
        }

        return experimentsFound;
    }
}
