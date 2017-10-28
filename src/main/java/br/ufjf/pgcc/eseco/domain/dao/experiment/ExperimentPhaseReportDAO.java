/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.domain.dao.experiment;

import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.ExperimentPhaseReport;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Lenita
 */
@Repository
public class ExperimentPhaseReportDAO extends CommonDAO<ExperimentPhaseReport, Integer> {

    protected ExperimentPhaseReportDAO() {
        super(ExperimentPhaseReport.class);
    }
}
