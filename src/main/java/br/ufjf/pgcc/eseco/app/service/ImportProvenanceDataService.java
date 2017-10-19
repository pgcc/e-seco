/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.app.service;

import br.ufjf.pgcc.eseco.domain.model.experiment.Experiment;
import br.ufjf.pgcc.eseco.domain.model.experiment.Workflow;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.logging.Level;
import java.util.logging.Logger;
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
        switch (workflow.getWfms().getName()) {
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
    private void importKeplerData(Experiment experiment, Workflow workflow, String filePath) {
        System.out.println(filePath);

        try {
            Object obj = new JsonParser().parse(new FileReader(filePath));

            JsonObject jsonObject = (JsonObject) obj;

            String author = jsonObject.getAsJsonObject("agent").getAsJsonObject("kepler:user").get("prov:label").getAsString();
            
            System.out.println("Nome: " + author);
           // String time = jsonObject.getAsJsonObject("prov:time").getAsString();
//            JSONArray companyList = (JSONArray) jsonObject.get("Company List");

        } catch (FileNotFoundException ex) {
            Logger.getLogger(ImportProvenanceDataService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
