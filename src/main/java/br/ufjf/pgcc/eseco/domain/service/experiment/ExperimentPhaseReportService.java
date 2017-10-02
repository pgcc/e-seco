package br.ufjf.pgcc.eseco.domain.service.experiment;

import br.ufjf.pgcc.eseco.domain.dao.experiment.ExperimentPhaseReportDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.ExperimentPhaseReport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class ExperimentPhaseReportService {

    private final ExperimentPhaseReportDAO experimentPhaseReportDAO;

    @Autowired
    public ExperimentPhaseReportService(ExperimentPhaseReportDAO experimentPhaseReportDAO) {
        this.experimentPhaseReportDAO = experimentPhaseReportDAO;
    }

    @Transactional
    public ExperimentPhaseReport saveOrUpdate(ExperimentPhaseReport experimentPhaseReport) throws Exception {
        if (experimentPhaseReport.getId() == 0 || find(experimentPhaseReport.getId()) == null) {
            return experimentPhaseReportDAO.add(experimentPhaseReport);
        } else {
            return experimentPhaseReportDAO.update(experimentPhaseReport);
        }
    }

    @Transactional
    public void delete(ExperimentPhaseReport experimentPhaseReport) throws Exception {
        experimentPhaseReportDAO.delete(experimentPhaseReport);
    }

    public ExperimentPhaseReport find(int experimentPhaseReportId) {
        return experimentPhaseReportDAO.find(experimentPhaseReportId);
    }

    public List<ExperimentPhaseReport> findAll() {
        return experimentPhaseReportDAO.findAll();
    }

}
