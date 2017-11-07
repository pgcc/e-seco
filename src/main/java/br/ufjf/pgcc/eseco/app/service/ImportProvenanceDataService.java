/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.app.service;

import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import br.ufjf.pgcc.eseco.domain.model.experiment.Activity;
import br.ufjf.pgcc.eseco.domain.model.experiment.ActivityExecution;
import br.ufjf.pgcc.eseco.domain.model.experiment.Data;
import br.ufjf.pgcc.eseco.domain.model.experiment.Document;
import br.ufjf.pgcc.eseco.domain.model.experiment.Entity;
import br.ufjf.pgcc.eseco.domain.model.experiment.Port;
import br.ufjf.pgcc.eseco.domain.model.experiment.Workflow;
import br.ufjf.pgcc.eseco.domain.model.experiment.WorkflowExecution;
import br.ufjf.pgcc.eseco.domain.service.core.ResearcherService;
import br.ufjf.pgcc.eseco.domain.service.experiment.ActivityExecutionService;
import br.ufjf.pgcc.eseco.domain.service.experiment.ActivityService;
import br.ufjf.pgcc.eseco.domain.service.experiment.DataService;
import br.ufjf.pgcc.eseco.domain.service.experiment.DocumentService;
import br.ufjf.pgcc.eseco.domain.service.experiment.EntityService;
import br.ufjf.pgcc.eseco.domain.service.experiment.PortService;
import br.ufjf.pgcc.eseco.domain.service.experiment.WorkflowExecutionService;
import br.ufjf.pgcc.eseco.domain.service.experiment.WorkflowService;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author Lenita
 */
@Service
public class ImportProvenanceDataService {

    private ResearcherService researcherService;
    private EntityService entityService;
    private DataService dataService;
    private DocumentService documentService;
    private ActivityService activityService;
    private ActivityExecutionService activityExecutionService;
    private WorkflowExecutionService workflowExecutionService;
    private PortService portService;
    private WorkflowService workflowService;

    private static final Logger LOGGER = Logger.getLogger(ImportProvenanceDataService.class.getName());

    @Autowired
    public ImportProvenanceDataService(ResearcherService researcherService, EntityService entityService,
            DataService dataService, DocumentService documentService, ActivityService activityService,
            ActivityExecutionService activityExecutionService, WorkflowExecutionService workflowExecutionService,
            PortService portService, WorkflowService workflowService) {
        this.researcherService = researcherService;
        this.entityService = entityService;
        this.dataService = dataService;
        this.documentService = documentService;
        this.activityService = activityService;
        this.activityExecutionService = activityExecutionService;
        this.workflowExecutionService = workflowExecutionService;
        this.portService = portService;
        this.workflowService = workflowService;
    }

    public ImportProvenanceDataService() {
    }

    /**
     * Imports the execution provenance data extracted from a WfMS
     *
     * @param workflow
     * @param filePath
     */
    public void importProvenanceData(Workflow workflow, String filePath, Researcher researcher) throws Exception {
        switch (workflow.getWfms().getName()) {
            case "Kepler":
                importKeplerData(workflow, filePath, researcher);
        }
    }

    /**
     * Imports the execution provenance data extracted from Kepler
     *
     * @param experiment
     * @param workflow
     * @param filePath
     */
    private void importKeplerData(Workflow workflow, String filePath, Researcher loggedResearcher) throws Exception {

        LOGGER.log(Level.INFO, "Importing Kepler Provenance Data. ", filePath);

        Map<String, Researcher> mapResearchers = new HashMap<>();
        WorkflowExecution workflowExecution = new WorkflowExecution();
        Map<String, Entity> mapEntities = new HashMap<>();
        Map<String, Activity> mapActivities = new HashMap<>();
        Map<String, ActivityExecution> mapActivitiesExecutions = new HashMap<>();

        try {
            //Read the JSON file
            JsonObject jsonObject = new JsonParser().parse(new FileReader(filePath)).getAsJsonObject();

            //Import the Agents
            JsonObject agents = jsonObject.get("agent").getAsJsonObject();
            for (Map.Entry<String, JsonElement> en : agents.entrySet()) {
                String key = en.getKey();
                JsonElement value = en.getValue();
                String keplerId = value.getAsJsonObject().get("prov:label").getAsString();
                System.out.println("agent: " + key + " name: " + keplerId);

                if (loggedResearcher.getKeplerId() != null && !loggedResearcher.getKeplerId().equalsIgnoreCase(keplerId)) {
                    Researcher findByKeplerId = researcherService.findByKeplerId(keplerId);
                    if (findByKeplerId != null) {
                        mapResearchers.put(key, findByKeplerId);
                        continue;
                    }
                }
                if (loggedResearcher.getKeplerId() == null || loggedResearcher.getKeplerId().isEmpty()) {
                    loggedResearcher.setKeplerId(keplerId);
                    loggedResearcher = researcherService.saveOrUpdate(loggedResearcher);
                    mapResearchers.put(key, loggedResearcher);
                    continue;
                }
                
                Researcher r = new Researcher();
                r.setKeplerId(keplerId);
                r.setDisplayName(keplerId);
                r = researcherService.saveOrUpdate(r);
                mapResearchers.put(key, r);
            }

            //Import the Entities
            JsonObject entities = jsonObject.get("entity").getAsJsonObject();

            //Import the workflow entity
            JsonObject keplerWorkflowExec = entities.getAsJsonObject("kepler:workflow");
            String workflowValue = keplerWorkflowExec.getAsJsonObject("prov:value").get("$").getAsString();
            String workflowName = keplerWorkflowExec.getAsJsonObject("kepler:actorName").get("$").getAsString();
            String startString = keplerWorkflowExec.getAsJsonObject("kepler:executionStartTime").get("$").getAsString();
            String endString = keplerWorkflowExec.getAsJsonObject("kepler:executionStopTime").get("$").getAsString();
            ZonedDateTime startDateTime = ZonedDateTime.parse(startString);
            ZonedDateTime endDateTime = ZonedDateTime.parse(endString);

            workflow.setValue(workflowValue);
            if (workflow.getName() == null) {
                workflow.setName(workflowName);
            }
            workflow = workflowService.saveOrUpdate(workflow);

            workflowExecution.setWorkflow(workflow);
            workflowExecution.setStartTime(Date.from(startDateTime.toInstant()));
            workflowExecution.setEndTime(Date.from(endDateTime.toInstant()));
            workflowExecution.setAuthor(loggedResearcher);
            workflowExecution = workflowExecutionService.saveOrUpdate(workflowExecution);

            entities.remove("kepler:workflow");

            //Import the others Entities
            for (Map.Entry<String, JsonElement> en : entities.entrySet()) {
                String key = en.getKey();
                JsonElement value = en.getValue();

                Entity entity = new Entity();
                entity.setName(key);
                entity = entityService.saveOrUpdate(entity);
                if (value.getAsJsonObject().get("kepler:tokenClass").getAsJsonObject().get("$").getAsString()
                        .equalsIgnoreCase("ptolemy.data.StringToken")) {
                    Document document = new Document();
                    document.setValue(value.getAsJsonObject().get("prov:value").getAsJsonObject().get("$").getAsString());
                    document.setEntity(entity);
                    document = documentService.saveOrUpdate(document);
                    entity.setDocument(document);
                } else {
                    Data data = new Data();
                    data.setValue(value.getAsJsonObject().get("prov:value").getAsJsonObject().get("$").getAsString());
                    String type = value.getAsJsonObject().get("kepler:tokenClass").getAsJsonObject().get("$").getAsString();
                    type = type.split("\\.")[type.split("\\.").length - 1].replace("Token", "");
                    data.setType(type);
                    data.setEntity(entity);
                    data = dataService.saveOrUpdate(data);
                    entity.setData(data);
                }
                entity = entityService.saveOrUpdate(entity);
                mapEntities.put(key, entity);
            }

            //Import the Activities
            JsonObject activities = jsonObject.get("activity").getAsJsonObject();
            for (Map.Entry<String, JsonElement> en : activities.entrySet()) {
                String key = en.getKey();
                JsonElement value = en.getValue();
                startString = value.getAsJsonObject().get("prov:startTime").getAsString();
                endString = value.getAsJsonObject().get("prov:endTime").getAsString();
                startDateTime = ZonedDateTime.parse(startString);
                endDateTime = ZonedDateTime.parse(endString);
                Activity activity = new Activity();
                String name = value.getAsJsonObject().get("kepler:actorName").getAsJsonObject().get("$").getAsString();
                name = name.split("\\.")[name.split("\\.").length - 1];
                activity.setName(name);
                activity.setDateCreated(Date.from(startDateTime.toInstant()));
                activity.setAuthor(loggedResearcher);

                if (workflow.getActivities() != null && !workflow.getActivities().isEmpty()) {
                    for (Activity ac : workflow.getActivities()) {
                        if (ac.getName().equalsIgnoreCase(activity.getName())) {
                            activity = ac;
                        }
                    }
                }
                activity = activityService.saveOrUpdate(activity);
                mapActivities.put(key, activity);

                ActivityExecution activityExecution = new ActivityExecution();
                activityExecution.setActivity(activity);
                activityExecution.setStartTime(Date.from(startDateTime.toInstant()));
                activityExecution.setEndTime(Date.from(endDateTime.toInstant()));
                activityExecution.setAuthor(loggedResearcher);

                activityExecution = activityExecutionService.saveOrUpdate(activityExecution);
                mapActivitiesExecutions.put(key, activityExecution);
            }

            if (workflowExecution.getInputs() == null) {
                workflowExecution.setInputs(new ArrayList<Port>());
            }
            if (workflowExecution.getOutputs() == null) {
                workflowExecution.setOutputs(new ArrayList<Port>());
            }

            //Imprt the Use relation
            JsonObject uses = jsonObject.get("used").getAsJsonObject();
            for (Map.Entry<String, JsonElement> en : uses.entrySet()) {
                String key = en.getKey();
                JsonElement value = en.getValue();

                Port port = new Port();
                port.setEntity(mapEntities.get(value.getAsJsonObject().get("prov:entity").getAsString()));
                port = portService.saveOrUpdate(port);

                ActivityExecution activityExecution = mapActivitiesExecutions.get(value.getAsJsonObject().get("prov:activity").getAsString());
                if (activityExecution.getInputs() == null) {
                    activityExecution.setInputs(new ArrayList<Port>());
                }
                activityExecution.getInputs().add(port);
                activityExecutionService.saveOrUpdate(activityExecution);

                workflowExecution.getInputs().add(port);
                workflowExecution = workflowExecutionService.saveOrUpdate(workflowExecution);
            }

            //Imprt the Was Generated By relation
            JsonObject generations = jsonObject.get("wasGeneratedBy").getAsJsonObject();
            for (Map.Entry<String, JsonElement> en : generations.entrySet()) {
                String key = en.getKey();
                JsonElement value = en.getValue();

                Port port = new Port();
                port.setEntity(mapEntities.get(value.getAsJsonObject().get("prov:entity").getAsString()));
                port = portService.saveOrUpdate(port);

                ActivityExecution activityExecution = mapActivitiesExecutions.get(value.getAsJsonObject().get("prov:activity").getAsString());
                if (activityExecution.getOutputs() == null) {
                    activityExecution.setOutputs(new ArrayList<Port>());
                }
                activityExecution.getOutputs().add(port);
                activityExecutionService.saveOrUpdate(activityExecution);

                workflowExecution.getOutputs().add(port);
                workflowExecution = workflowExecutionService.saveOrUpdate(workflowExecution);
            }

            //Import the Associations
            JsonObject associations = jsonObject.get("wasAssociatedWith").getAsJsonObject();
            for (Map.Entry<String, JsonElement> en : associations.entrySet()) {
                String key = en.getKey();
                JsonElement value = en.getValue();

                Researcher researcher = mapResearchers.get(value.getAsJsonObject().get("prov:agent").getAsString());

                Activity activity = mapActivities.get(value.getAsJsonObject().get("prov:activity").getAsString());
                if (workflow.getActivities() == null) {
                    workflow.setActivities(new ArrayList<Activity>());
                }
                workflow.getActivities().add(activity);
                workflow = workflowService.saveOrUpdate(workflow);

                ActivityExecution activityExecution = mapActivitiesExecutions.get(value.getAsJsonObject().get("prov:activity").getAsString());
                activityExecution.setAuthor(researcher);
                activityExecutionService.saveOrUpdate(activityExecution);

                if (workflowExecution.getActivityExecutions() == null) {
                    workflowExecution.setActivityExecutions(new ArrayList<ActivityExecution>());
                }
                workflowExecution.getActivityExecutions().add(activityExecution);
                workflowExecution.setAuthor(researcher);
                workflowExecution = workflowExecutionService.saveOrUpdate(workflowExecution);
            }
            LOGGER.log(Level.INFO, "Successfully imported Provenance Data.");
        } catch (FileNotFoundException ex) {
            LOGGER.log(Level.SEVERE, null, ex);
        }
    }
}
