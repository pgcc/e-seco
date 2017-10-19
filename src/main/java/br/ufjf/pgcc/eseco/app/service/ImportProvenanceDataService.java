/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.app.service;

import br.ufjf.pgcc.eseco.domain.model.experiment.Experiment;
import br.ufjf.pgcc.eseco.domain.model.experiment.Workflow;
import org.springframework.stereotype.Service;

/**
 *
 * @author Lenita
 */
@Service
public class ImportProvenanceDataService {

    /**
     * Imports the execution provenance data extracted from a WfMS
     * 
     * @param experiment
     * @param workflow
     * @param filePath 
     */
    public void importProvenanceData(Experiment experiment, Workflow workflow, String filePath) {
        switch (workflow.getWfms().getName()){
            case "Kepler":
                importKeplerData(experiment, workflow, filePath);
        }
    }
    
    /**
     * Imports the execution provenance data extracted from Kepler
     * 
     * @param experiment
     * @param workflow
     * @param filePath 
     */
    private void importKeplerData(Experiment experiment, Workflow workflow, String filePath){
        System.out.println(filePath);
    }

}
