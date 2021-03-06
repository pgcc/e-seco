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
import br.ufjf.pgcc.eseco.domain.model.experiment.Experiment;
import br.ufjf.pgcc.eseco.domain.model.experiment.Port;
import br.ufjf.pgcc.eseco.domain.model.experiment.Workflow;
import br.ufjf.pgcc.eseco.domain.model.experiment.WorkflowActivity;
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
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;
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

    private Map<String, String> primitiveTypes = new HashMap<>();

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

        primitiveTypes.put("ptolemy.data.BooleanToken", "Boolean");
        primitiveTypes.put("ptolemy.data.DoubleToken", "Double");
        primitiveTypes.put("ptolemy.data.FloatToken", "Float");
        primitiveTypes.put("ptolemy.data.IntToken", "Int");
        primitiveTypes.put("ptolemy.data.LongToken", "Long");
        primitiveTypes.put("ptolemy.data.StringToken", "String");

    }

    public ImportProvenanceDataService() {
    }

    /**
     * Imports the execution provenance data extracted from a WfMS
     *
     * @param experiment
     * @param workflow
     * @param bytes
     * @param researcher
     * @throws java.lang.Exception
     */
    public void importProvenanceData(Experiment experiment, Workflow workflow, byte[] bytes, Researcher researcher) throws Exception {
        switch (workflow.getWfms().getName()) {
            case "Kepler":
                try {
                    importKeplerData(experiment, workflow, bytes, researcher);
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
        }
    }

    /**
     * Imports the execution provenance data extracted from Kepler
     *
     * @param experiment
     * @param workflow
     * @param filePath
     * @param loggedResearcher
     * @throws Exception
     */
    private void importKeplerData(Experiment experiment, Workflow workflow, byte[] bytes, Researcher loggedResearcher) throws Exception {

        LOGGER.log(Level.INFO, "Importing Kepler Provenance Data. ");

        Map<String, Researcher> mapResearchers = new HashMap<>();
        WorkflowExecution workflowExecution = new WorkflowExecution();
        Map<String, Entity> mapEntities = new HashMap<>();
        Map<String, Activity> mapActivities = new HashMap<>();
        Map<String, ActivityExecution> mapActivitiesExecutions = new HashMap<>();

        try {
            //Read the JSON file
            JsonObject jsonObject = new JsonParser().parse(new String(bytes)).getAsJsonObject();

            //Import the Agents
            JsonObject agents = jsonObject.get("agent").getAsJsonObject();
            for (Map.Entry<String, JsonElement> en : agents.entrySet()) {
                String key = en.getKey();
                JsonElement value = en.getValue();
                String keplerId = value.getAsJsonObject().get("prov:label").getAsString();

                Researcher findByKeplerId = researcherService.findByKeplerId(keplerId);
                if (findByKeplerId != null) {
                    loggedResearcher = findByKeplerId;
                    mapResearchers.put(key, findByKeplerId);

                } else if (loggedResearcher.getKeplerId() == null || loggedResearcher.getKeplerId().isEmpty()) {
                    loggedResearcher.setKeplerId(keplerId);
                    loggedResearcher = researcherService.saveOrUpdate(loggedResearcher);
                    mapResearchers.put(key, loggedResearcher);

                } else {
                    Researcher r = new Researcher();
                    r.setKeplerId(keplerId);
                    r.setDisplayName(keplerId);
                    r = researcherService.saveOrUpdate(r);
                    mapResearchers.put(key, r);
                }
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
            workflowExecution.setExperiment(experiment);
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
                entity.setAuthor(loggedResearcher);
                entity = entityService.saveOrUpdate(entity);
                String content = value.getAsJsonObject().get("prov:value").getAsJsonObject().get("$").getAsString();
                if (!primitiveTypes.containsKey(value.getAsJsonObject().get("kepler:tokenClass").getAsJsonObject().get("$").getAsString())
                        || content.endsWith(".csv") || content.endsWith(".pdf") || content.endsWith(".doc") || content.endsWith(".xlsx")) {
                    Document document = new Document();
                    document.setValue(content);
                    document.setEntity(entity);
                    document.setFile(content);
                    if ((content.endsWith(".csv") || content.endsWith(".pdf") || content.endsWith(".doc") || content.endsWith(".xlsx"))
                            && content.split(Pattern.quote("\\")).length > 0) {
                        String name = content.split(Pattern.quote("\\"))[content.split(Pattern.quote("\\")).length - 1];
                        entity.setName(name);
                    }
                    String type = value.getAsJsonObject().get("kepler:tokenClass").getAsJsonObject().get("$").getAsString();
                    type = type.split("\\.")[type.split("\\.").length - 1];
                    document.setType(type);
                    document = documentService.saveOrUpdate(document);
                    entity.setDocument(document);
                } else {
                    Data data = new Data();
                    data.setValue(content);
                    String type = value.getAsJsonObject().get("kepler:tokenClass").getAsJsonObject().get("$").getAsString();
                    data.setType(primitiveTypes.get(type));
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
                activity.setAuthor(loggedResearcher);

                activity.setDateCreated(Date.from(startDateTime.toInstant()));

                if (workflow.getActivities() != null && !workflow.getActivities().isEmpty()) {
                    for (WorkflowActivity wa : workflow.getActivities()) {
                        if (wa.getActivity().getName().equalsIgnoreCase(activity.getName())) {
                            activity = wa.getActivity();
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
            if (workflowExecution.getActivityExecutions() == null) {
                workflowExecution.setActivityExecutions(new ArrayList<ActivityExecution>());
            }

            //Import the Use relation
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
                workflowExecution.getActivityExecutions().add(activityExecution);
                try {
                    workflowExecution = workflowExecutionService.saveOrUpdate(workflowExecution);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            //Import the Was Generated By relation
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
                    workflow.setActivities(new ArrayList<WorkflowActivity>());
                }
                
                workflow.addActivity(activity);
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
