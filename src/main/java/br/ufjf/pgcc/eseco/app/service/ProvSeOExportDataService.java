/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.app.service;

import br.ufjf.pgcc.eseco.domain.model.core.City;
import br.ufjf.pgcc.eseco.domain.model.core.Developer;
import br.ufjf.pgcc.eseco.domain.model.core.Discipline;
import br.ufjf.pgcc.eseco.domain.model.core.Institution;
import br.ufjf.pgcc.eseco.domain.model.core.Interest;
import br.ufjf.pgcc.eseco.domain.model.core.ResearchGroup;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import br.ufjf.pgcc.eseco.domain.model.core.ResearcherKeyword;
import br.ufjf.pgcc.eseco.domain.model.experiment.Activity;
import br.ufjf.pgcc.eseco.domain.model.experiment.ActivityExecution;
import br.ufjf.pgcc.eseco.domain.model.experiment.Data;
import br.ufjf.pgcc.eseco.domain.model.experiment.Detail;
import br.ufjf.pgcc.eseco.domain.model.experiment.Document;
import br.ufjf.pgcc.eseco.domain.model.experiment.Experiment;
import br.ufjf.pgcc.eseco.domain.model.experiment.Port;
import br.ufjf.pgcc.eseco.domain.model.experiment.Wfms;
import br.ufjf.pgcc.eseco.domain.model.experiment.Workflow;
import br.ufjf.pgcc.eseco.domain.model.experiment.WorkflowActivity;
import br.ufjf.pgcc.eseco.domain.model.experiment.WorkflowExecution;
import br.ufjf.pgcc.eseco.domain.service.core.AgentService;
import br.ufjf.pgcc.eseco.domain.service.core.CityService;
import br.ufjf.pgcc.eseco.domain.service.core.CountryService;
import br.ufjf.pgcc.eseco.domain.service.core.DeveloperService;
import br.ufjf.pgcc.eseco.domain.service.core.DisciplineService;
import br.ufjf.pgcc.eseco.domain.service.core.InstitutionService;
import br.ufjf.pgcc.eseco.domain.service.core.InterestService;
import br.ufjf.pgcc.eseco.domain.service.core.ResearchGroupService;
import br.ufjf.pgcc.eseco.domain.service.core.ResearcherKeywordService;
import br.ufjf.pgcc.eseco.domain.service.core.ResearcherService;
import br.ufjf.pgcc.eseco.domain.service.core.StateService;
import br.ufjf.pgcc.eseco.domain.service.experiment.ActivityExecutionService;
import br.ufjf.pgcc.eseco.domain.service.experiment.ActivityService;
import br.ufjf.pgcc.eseco.domain.service.experiment.DataService;
import br.ufjf.pgcc.eseco.domain.service.experiment.DocumentService;
import br.ufjf.pgcc.eseco.domain.service.experiment.EntityService;
import br.ufjf.pgcc.eseco.domain.service.experiment.ExperimentService;
import br.ufjf.pgcc.eseco.domain.service.experiment.PortService;
import br.ufjf.pgcc.eseco.domain.service.experiment.WfmsService;
import br.ufjf.pgcc.eseco.domain.service.experiment.WorkflowExecutionService;
import br.ufjf.pgcc.eseco.domain.service.experiment.WorkflowService;
import br.ufjf.pgcc.eseco.domain.service.resource.WorkflowServiceService;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import java.util.List;
import java.util.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author Lenita
 */
@Service
public class ProvSeOExportDataService {

    private static final Logger LOGGER = Logger.getLogger(MendeleyService.class.getName());

    private final AgentService agentService;
    private final CityService cityService;
    private final CountryService countryService;
    private final DeveloperService developerService;
    private final DisciplineService disciplineService;
    private final InstitutionService institutionService;
    private final InterestService interestService;
    private final ResearchGroupService researchGroupService;
    private final ResearcherService researcherService;
    private final ResearcherKeywordService researcherKeywordService;
    private final StateService stateService;

    private final ActivityService activityService;
    private final ActivityExecutionService activityExecutionService;
    private final DataService dataService;
    private final DocumentService documentService;
    private final EntityService entityService;
    private final ExperimentService experimentService;
    private final PortService portService;
    private final WfmsService wfmsService;
    private final WorkflowService workflowService;
    private final WorkflowExecutionService workflowExecutionService;
    private final WorkflowServiceService workflowServiceService;

    private JsonObject jObject;

    @Autowired
    public ProvSeOExportDataService(AgentService agentService, CityService cityService, CountryService countryService, DeveloperService developerService, DisciplineService disciplineService, InstitutionService institutionService, InterestService interestService, ResearchGroupService researchGroupService, ResearcherService researcherService, ResearcherKeywordService researcherKeywordService, StateService stateService, ActivityService activityService, ActivityExecutionService activityExecutionService, DataService dataService, DocumentService documentService, EntityService entityService, ExperimentService experimentService, PortService portService, WfmsService wfmsService, WorkflowService workflowService, WorkflowExecutionService workflowExecutionService, WorkflowServiceService workflowServiceService) {
        this.agentService = agentService;
        this.cityService = cityService;
        this.countryService = countryService;
        this.developerService = developerService;
        this.disciplineService = disciplineService;
        this.institutionService = institutionService;
        this.interestService = interestService;
        this.researchGroupService = researchGroupService;
        this.researcherService = researcherService;
        this.researcherKeywordService = researcherKeywordService;
        this.stateService = stateService;
        this.activityService = activityService;
        this.activityExecutionService = activityExecutionService;
        this.dataService = dataService;
        this.documentService = documentService;
        this.entityService = entityService;
        this.experimentService = experimentService;
        this.portService = portService;
        this.wfmsService = wfmsService;
        this.workflowService = workflowService;
        this.workflowExecutionService = workflowExecutionService;
        this.workflowServiceService = workflowServiceService;
    }

    public JsonObject getData() {
        jObject = new JsonObject();
        getObjects();
        getRelations();

//        try (FileOutputStream fout = new FileOutputStream(System.getProperty("user.home") + "\\AppData\\Local\\Temp\\ProvenanceExport.json")) {
//            fout.write(jObject.toString().getBytes(StandardCharsets.UTF_8));
//            fout.flush();
//            fout.close();
//
//        } catch (FileNotFoundException ex) {
//            Logger.getLogger(ProvSeOExportDataService.class.getName()).log(Level.SEVERE, null, ex);
//        } catch (IOException ex) {
//            Logger.getLogger(ProvSeOExportDataService.class.getName()).log(Level.SEVERE, null, ex);
//        }
        return jObject;
    }

    private void getObjects() {
        JsonObject jObjectAgent = new JsonObject();
        jObject.add("agent", jObjectAgent);
        getAgentsData();

        JsonObject jObjectEntity = new JsonObject();
        jObject.add("entity", jObjectEntity);
        getEntitiesData();

        JsonObject jObjectActivity = new JsonObject();
        jObject.add("activity", jObjectActivity);
        getActivitiesData();

        JsonObject jObjectLocation = new JsonObject();
        jObject.add("location", jObjectLocation);
        getLocation();

    }

    private void getRelations() {

        JsonArray jObjecthasMember = new JsonArray();
        jObject.add("hasMember", jObjecthasMember);

        JsonArray jObjectwasAttributedTo = new JsonArray();
        jObject.add("wasAttributedTo", jObjectwasAttributedTo);

        JsonArray jObjectwasInfluencedBy = new JsonArray();
        jObject.add("wasInfluencedBy", jObjectwasInfluencedBy);

        JsonArray jObjecthasSubProgram = new JsonArray();
        jObject.add("hasSubProgram", jObjecthasSubProgram);

        JsonArray jObjectcontrolledBy = new JsonArray();
        jObject.add("controlledBy", jObjectcontrolledBy);

        JsonArray jObjecthasDefaultParam = new JsonArray();
        jObject.add("hasDefaultParam", jObjecthasDefaultParam);

        JsonArray jObjectactedOnBehalfOf = new JsonArray();
        jObject.add("actedOnBehalfOf", jObjectactedOnBehalfOf);

        JsonArray jObjectwasPartOf = new JsonArray();
        jObject.add("wasPartOf", jObjectwasPartOf);

        JsonArray jObjectwasAssociatedWith = new JsonArray();
        jObject.add("wasAssociatedWith", jObjectwasAssociatedWith);

        JsonArray jObjecthadPlan = new JsonArray();
        jObject.add("hadPlan", jObjecthadPlan);

        JsonArray jObjectagent = new JsonArray();
        jObject.add("agentRelation", jObjectagent);

        JsonArray jObjectUsed = new JsonArray();
        jObject.add("used", jObjectUsed);

        JsonArray jObjecthadInPort = new JsonArray();
        jObject.add("hadInPort", jObjecthadInPort);

        JsonArray jObjecthadOutPort = new JsonArray();
        jObject.add("hadOutPort", jObjecthadOutPort);

        JsonArray jObjecthasInPort = new JsonArray();
        jObject.add("hasInPort", jObjecthasInPort);

        JsonArray jObjecthasOutPort = new JsonArray();
        jObject.add("hasOutPort", jObjecthasOutPort);

        JsonArray jObjecthadEntity = new JsonArray();
        jObject.add("hadEntity", jObjecthadEntity);

        JsonArray jObjectqualifiedAssociation = new JsonArray();
        jObject.add("qualifiedAssociation", jObjectqualifiedAssociation);

        JsonArray jObjectqualifiedUsage = new JsonArray();
        jObject.add("qualifiedUsage", jObjectqualifiedUsage);

        JsonArray jObjectqualifiedGeneration = new JsonArray();
        jObject.add("qualifiedGeneration", jObjectqualifiedGeneration);

        getExperimentRelations();
        getWorkflowRelations();
        getActivityRelations();
        getPortRelations();
        getResearcherRelations();
        getWorkflowExecutionsRelations();
    }

    private void getAgentsData() {
        getOrganizationsData();
        getUserData();
        getSoftwareAgentsData();
    }

    private void getEntitiesData() {
        getCollectionsData();
        getPlansData();

        JsonObject entityAsJson = jObject.getAsJsonObject("entity");
        List<Data> data = dataService.findAll();
        JsonArray jArrayData = new JsonArray();
        for (Data d : data) {
            JsonObject dataJSON = new JsonObject();
            dataJSON.addProperty("id", d.getEntity().getId());
            dataJSON.addProperty("type", d.getType());
            dataJSON.addProperty("value", d.getValue());
            if (d.getEntity() != null) {
                dataJSON.addProperty("name", d.getEntity().getName());
            }
            jArrayData.add(dataJSON);
        }

        entityAsJson.add("data", jArrayData);

        List<Document> documents = documentService.findAll();
        JsonArray jArrayDocuments = new JsonArray();
        for (Document d : documents) {
            JsonObject documentJSON = new JsonObject();
            documentJSON.addProperty("id", d.getEntity().getId());
            documentJSON.addProperty("type", d.getType());
            documentJSON.addProperty("value", d.getValue());
            documentJSON.addProperty("link", d.getFile());
            if (d.getEntity() != null) {
                documentJSON.addProperty("name", d.getEntity().getName());
            }
            jArrayDocuments.add(documentJSON);
        }
        entityAsJson.add("document", jArrayDocuments);

        List<Port> ports = portService.findAll();
        JsonArray jArrayPorts = new JsonArray();
        for (Port p : ports) {
            JsonObject portJSON = new JsonObject();
            portJSON.addProperty("id", p.getId());
            jArrayPorts.add(portJSON);
        }

        entityAsJson.add("port", jArrayPorts);
    }

    private void getActivitiesData() {

        JsonObject activityAsJson = jObject.getAsJsonObject("activity");
        List<WorkflowExecution> workflowExecutions = workflowExecutionService.findAll();
        JsonArray jArrayWorkflowExecutions = new JsonArray();
        for (WorkflowExecution we : workflowExecutions) {
            JsonObject workflowExecutionJSON = new JsonObject();
            workflowExecutionJSON.addProperty("id", we.getId());

            if (we.getStartTime() != null) {
                workflowExecutionJSON.addProperty("startedAtTime", we.getStartTime().toString());
            }

            if (we.getEndTime() != null) {
                workflowExecutionJSON.addProperty("endedAtTime", we.getEndTime().toString());
            }
            jArrayWorkflowExecutions.add(workflowExecutionJSON);
        }
        activityAsJson.add("workflowExecution", jArrayWorkflowExecutions);

        List<ActivityExecution> activityExecutions = activityExecutionService.findAll();
        JsonArray jArrayActivityExecutions = new JsonArray();
        for (ActivityExecution ae : activityExecutions) {
            JsonObject activityExecutionJSON = new JsonObject();
            activityExecutionJSON.addProperty("id", ae.getId());

            if (ae.getStartTime() != null) {
                activityExecutionJSON.addProperty("startedAtTime", ae.getStartTime().toString());
            }

            if (ae.getEndTime() != null) {
                activityExecutionJSON.addProperty("endedAtTime", ae.getEndTime().toString());
            }
            jArrayActivityExecutions.add(activityExecutionJSON);
        }
        activityAsJson.add("activityExecution", jArrayActivityExecutions);
    }

    private void getLocation() {
        JsonObject locationAsJson = jObject.getAsJsonObject("location");
        List<City> cities = cityService.findAll();
        JsonArray jArrayCities = new JsonArray();
        for (City c : cities) {
            JsonObject cityJSON = new JsonObject();
            cityJSON.addProperty("id", c.getId());
            cityJSON.addProperty("name", c.getName());
            jArrayCities.add(cityJSON);
        }
        locationAsJson.add("city", jArrayCities);
    }

    private void getUserData() {
        JsonObject agentAsJson = jObject.getAsJsonObject("agent");
        List<Researcher> researchers = researcherService.findAll();
        JsonArray jArrayResearchers = new JsonArray();
        for (Researcher r : researchers) {
            JsonObject agentJSON = new JsonObject();
            agentJSON.addProperty("id", r.getId());
            agentJSON.addProperty("academicStatus", r.getAcademicStatus());
            agentJSON.addProperty("keplerId", r.getKeplerId());
            agentJSON.addProperty("mendeleyId", r.getMendeleyId());
            agentJSON.addProperty("title", r.getTitle());
            if (r.getAgent() != null) {
                agentJSON.addProperty("displayName", r.getDisplayName());
                if (r.getAgent().getBirthday() != null) {
                    agentJSON.addProperty("birthday", r.getAgent().getBirthday().toString());
                }
                agentJSON.addProperty("name", r.getAgent().getName());
                agentJSON.addProperty("photo", r.getPhoto());
            }

            JsonArray jArrayDisciplines = new JsonArray();
            for (Discipline d : r.getDisciplines()) {
                jArrayDisciplines.add(d.getName());
            }
            agentJSON.add("discipline", jArrayDisciplines);

            JsonArray jArrayKeyWords = new JsonArray();
            for (ResearcherKeyword k : r.getResearchKeywords()) {
                jArrayKeyWords.add(k.getName());
            }
            agentJSON.add("keyWord", jArrayKeyWords);

            JsonArray jArrayInterests = new JsonArray();
            for (Interest i : r.getResearchInterests()) {
                jArrayInterests.add(i.getName());
            }
            agentJSON.add("interest", jArrayInterests);
            jArrayResearchers.add(agentJSON);

        }
        agentAsJson.add("researcher", jArrayResearchers);

        List<Developer> developers = developerService.findAll();
        JsonArray jArrayDevelopers = new JsonArray();
        for (Developer d : developers) {
            JsonObject agentJSON = new JsonObject();
            agentJSON.addProperty("id", d.getId());
            if (d.getAgent() != null) {
                agentJSON.addProperty("birthday", d.getAgent().getBirthday().toString());
                agentJSON.addProperty("name", d.getAgent().getName());
                agentJSON.addProperty("photo", d.getPhoto());
            }
            jArrayDevelopers.add(agentJSON);
        }
        agentAsJson.add("developer", jArrayDevelopers);
    }

    private void getOrganizationsData() {
        JsonObject agentAsJson = jObject.getAsJsonObject("agent");
        List<Institution> institutions = institutionService.findAll();
        JsonArray jArrayInstitutions = new JsonArray();
        for (Institution i : institutions) {
            JsonObject institutionJSON = new JsonObject();
            institutionJSON.addProperty("id", i.getId());
            institutionJSON.addProperty("name", i.getName());

            jArrayInstitutions.add(institutionJSON);
        }
        agentAsJson.add("institution", jArrayInstitutions);

        List<ResearchGroup> researchGroups = researchGroupService.findAll();
        JsonArray jArrayResearchGroups = new JsonArray();
        for (ResearchGroup r : researchGroups) {
            JsonObject researchGroupJSON = new JsonObject();
            researchGroupJSON.addProperty("id", r.getId());
            researchGroupJSON.addProperty("name", r.getName());
            researchGroupJSON.addProperty("description", r.getDescription());
            researchGroupJSON.addProperty("webPage", r.getWebPage());

            jArrayResearchGroups.add(researchGroupJSON);
        }
        agentAsJson.add("researchGroup", jArrayResearchGroups);
    }

    private void getSoftwareAgentsData() {
        JsonObject agentAsJson = jObject.getAsJsonObject("agent");
        List<br.ufjf.pgcc.eseco.domain.model.resource.WorkflowService> workflowServices = workflowServiceService.findAll();
        JsonArray jArrayWorkflowServices = new JsonArray();
        for (br.ufjf.pgcc.eseco.domain.model.resource.WorkflowService ws : workflowServices) {
            JsonObject workflowServiceJSON = new JsonObject();
            workflowServiceJSON.addProperty("id", ws.getId());
            workflowServiceJSON.addProperty("description", ws.getDescription());
            workflowServiceJSON.addProperty("internalClass", ws.getInternalClass());
            workflowServiceJSON.addProperty("nature", ws.getNature());
            workflowServiceJSON.addProperty("shortDescription", ws.getShortDescription());
            workflowServiceJSON.addProperty("type", ws.getType());
            workflowServiceJSON.addProperty("url", ws.getUrl());

            jArrayWorkflowServices.add(workflowServiceJSON);
        }
        agentAsJson.add("service", jArrayWorkflowServices);

        List<Wfms> wfmss = wfmsService.findAll();
        JsonArray jArrayWfmss = new JsonArray();
        for (Wfms w : wfmss) {
            JsonObject wfmsJSON = new JsonObject();
            wfmsJSON.addProperty("id", w.getId());
            wfmsJSON.addProperty("name", w.getName());
            wfmsJSON.addProperty("link", w.getLink());

            jArrayWfmss.add(wfmsJSON);
        }
        agentAsJson.add("wfms", jArrayWfmss);
    }

    private void getCollectionsData() {
        JsonObject entityAsJson = jObject.getAsJsonObject("entity");
        List<Experiment> experiments = experimentService.findAll();
        JsonArray jArrayExperiments = new JsonArray();
        for (Experiment e : experiments) {
            JsonObject experimentJSON = new JsonObject();
            experimentJSON.addProperty("id", e.getId());
            experimentJSON.addProperty("name", e.getName());
            experimentJSON.addProperty("description", e.getDescription());
            experimentJSON.addProperty("version", e.getVersion());
            experimentJSON.addProperty("phase", e.getCurrentPhase().toString());
            if (e.getDateCreated() != null) {
                experimentJSON.addProperty("generatedAtTime", e.getDateCreated().toString());
            }
            if (e.getDateEnded() != null) {
                experimentJSON.addProperty("endedAtTime", e.getDateEnded().toString());
            }
            if (e.getDateUpdated() != null) {
                experimentJSON.addProperty("updatedAtTime", e.getDateUpdated().toString());
            }
            if (e.getStatus() != null) {
                experimentJSON.addProperty("status", e.getStatus().toString());
            }

            JsonArray jArrayDisciplines = new JsonArray();
            for (Discipline d : e.getDisciplines()) {
                jArrayDisciplines.add(d.getName());
            }
            experimentJSON.add("discipline", jArrayDisciplines);

            JsonArray jArrayDetail = new JsonArray();
            for (Detail d : e.getDetails()) {
                JsonObject detail = new JsonObject();
                detail.addProperty("name", d.getName());
                detail.addProperty("description", d.getDescription());
                jArrayDetail.add(detail);
            }
            experimentJSON.add("detail", jArrayDetail);

            jArrayExperiments.add(experimentJSON);
        }
        entityAsJson.add("experiment", jArrayExperiments);
    }

    private void getPlansData() {
        JsonObject entityAsJson = jObject.getAsJsonObject("entity");
        List<Workflow> workflows = workflowService.findAll();
        JsonArray jArrayWorkflows = new JsonArray();
        for (Workflow w : workflows) {
            JsonObject workflowJSON = new JsonObject();
            workflowJSON.addProperty("id", w.getId());
            workflowJSON.addProperty("name", w.getName());
            workflowJSON.addProperty("description", w.getDescription());
            workflowJSON.addProperty("link", w.getLink());
            //workflowJSON.addProperty("value", w.getValue());
            workflowJSON.addProperty("version", w.getVersion());
            if (w.getDateCreated() != null) {
                workflowJSON.addProperty("generatedAtTime", w.getDateCreated().toString());
            }

            jArrayWorkflows.add(workflowJSON);
        }
        entityAsJson.add("workflow", jArrayWorkflows);

        List<Activity> activities = activityService.findAll();
        JsonArray jArrayActivities = new JsonArray();
        for (Activity a : activities) {
            JsonObject activityJSON = new JsonObject();
            activityJSON.addProperty("id", a.getId());
            activityJSON.addProperty("name", a.getName());
            activityJSON.addProperty("description", a.getDescription());

            if (a.getDateCreated() != null) {
                activityJSON.addProperty("generatedAtTime", a.getDateCreated().toString());
            }

            JsonArray jArrayDetail = new JsonArray();
            for (Detail d : a.getDetails()) {
                JsonObject detail = new JsonObject();
                detail.addProperty("name", d.getName());
                detail.addProperty("description", d.getDescription());
                jArrayDetail.add(detail);
            }
            activityJSON.add("detail", jArrayDetail);
            jArrayActivities.add(activityJSON);
        }
        entityAsJson.add("program", jArrayActivities);
    }

    private void getExperimentRelations() {
        JsonArray hasMemberAsJson = jObject.getAsJsonArray("hasMember");
        JsonArray wasAttributedToAsJson = jObject.getAsJsonArray("wasAttributedTo");
        JsonArray wasInfluencedByAsJson = jObject.getAsJsonArray("wasInfluencedBy");

        List<Experiment> experiments = experimentService.findAll();
        for (Experiment e : experiments) {

            for (Workflow w : e.getWorkflows()) {
                JsonObject hasMemberJSON = new JsonObject();
                hasMemberJSON.addProperty("experiment", e.getId());
                hasMemberJSON.addProperty("workflow", w.getId());
                hasMemberAsJson.add(hasMemberJSON);
            }

            JsonObject wasAttributedToJSON = new JsonObject();
            wasAttributedToJSON.addProperty("experiment", e.getId());
            wasAttributedToJSON.addProperty("researcher", e.getAuthor().getId());
            wasAttributedToAsJson.add(wasAttributedToJSON);

            for (Institution i : e.getInstitutions()) {
                JsonObject wasInfluencedByJSON = new JsonObject();
                wasInfluencedByJSON.addProperty("experiment", e.getId());
                wasInfluencedByJSON.addProperty("institution", i.getId());
                wasInfluencedByAsJson.add(wasInfluencedByJSON);
            }

            for (ResearchGroup rg : e.getResearchGroups()) {
                JsonObject wasInfluencedByJSON = new JsonObject();
                wasInfluencedByJSON.addProperty("experiment", e.getId());
                wasInfluencedByJSON.addProperty("researchGroup", rg.getId());
                wasInfluencedByAsJson.add(wasInfluencedByJSON);
            }
        }
    }

    private void getWorkflowRelations() {
        JsonArray hasSubProgramAsJson = jObject.getAsJsonArray("hasSubProgram");
        JsonArray wasAttributedToAsJson = jObject.getAsJsonArray("wasAttributedTo");

        List<Workflow> workflows = workflowService.findAll();
        for (Workflow w : workflows) {

            for (WorkflowActivity wa : w.getActivities()) {
                JsonObject hasSubProgramJSON = new JsonObject();
                hasSubProgramJSON.addProperty("workflow", w.getId());
                hasSubProgramJSON.addProperty("program", wa.getId().getActivityId());
                hasSubProgramAsJson.add(hasSubProgramJSON);
            }

            JsonObject wasAttributedToJSON = new JsonObject();
            wasAttributedToJSON.addProperty("workflow", w.getId());
            wasAttributedToJSON.addProperty("researcher", w.getAuthor().getId());
            wasAttributedToAsJson.add(wasAttributedToJSON);

        }
    }

    private void getActivityRelations() {
        JsonArray controlledByAsJson = jObject.getAsJsonArray("controlledBy");
        JsonArray wasAttributedToAsJson = jObject.getAsJsonArray("wasAttributedTo");

        List<Activity> activities = activityService.findAll();
        for (Activity a : activities) {

            for (br.ufjf.pgcc.eseco.domain.model.resource.WorkflowService ws : a.getWorkflowServices()) {
                JsonObject controlledByJSON = new JsonObject();
                controlledByJSON.addProperty("program", a.getId());
                controlledByJSON.addProperty("controller", a.getId());
                controlledByAsJson.add(controlledByJSON);
            }
            if (a.getAuthor() != null) {
                JsonObject wasAttributedToJSON = new JsonObject();
                wasAttributedToJSON.addProperty("program", a.getId());
                wasAttributedToJSON.addProperty("researcher", a.getAuthor().getId());
                wasAttributedToAsJson.add(wasAttributedToJSON);
            }

        }
    }

    private void getPortRelations() {
        JsonArray hasDefaultParamAsJson = jObject.getAsJsonArray("hasDefaultParam");

        for (Port p : portService.findAll()) {
            JsonObject hasDefaultParamJSON = new JsonObject();
            hasDefaultParamJSON.addProperty("port", p.getId());
            switch (p.getEntity().getKind()) {
                case DATA:
                    hasDefaultParamJSON.addProperty("data", p.getEntity().getId());
                case DOCUMENT:
                    hasDefaultParamJSON.addProperty("document", p.getEntity().getId());
            }
            hasDefaultParamAsJson.add(hasDefaultParamJSON);
        }
    }

    private void getResearcherRelations() {
        JsonArray actedOnBehalfOfAsJson = jObject.getAsJsonArray("actedOnBehalfOf");

        for (Researcher r : researcherService.findAll()) {
            for (Institution i : r.getInstitutions()) {
                JsonObject actedOnBehalfOfJSON = new JsonObject();
                actedOnBehalfOfJSON.addProperty("researcher", r.getId());
                actedOnBehalfOfJSON.addProperty("institution", i.getId());
                actedOnBehalfOfAsJson.add(actedOnBehalfOfJSON);
            }
        }

        for (ResearchGroup rg : researchGroupService.findAll()) {
            for (Researcher r : rg.getMembers()) {
                JsonObject actedOnBehalfOfJSON = new JsonObject();
                actedOnBehalfOfJSON.addProperty("researcher", r.getId());
                actedOnBehalfOfJSON.addProperty("researchGroup", rg.getId());
                actedOnBehalfOfAsJson.add(actedOnBehalfOfJSON);
            }
        }

    }

    private void getWorkflowExecutionsRelations() {
        JsonArray wasPartOfAsJson = jObject.getAsJsonArray("wasPartOf");
        JsonArray wasAssociatedWithJson = jObject.getAsJsonArray("wasAssociatedWith");
        JsonArray usedJson = jObject.getAsJsonArray("used");

        JsonArray hadPlanJson = jObject.getAsJsonArray("hadPlan");
        JsonArray agentRelationJson = jObject.getAsJsonArray("agentRelation");
        JsonArray hadInPortJson = jObject.getAsJsonArray("hadInPort");
        JsonArray hadOutPortJson = jObject.getAsJsonArray("hadOutPort");
        JsonArray hasInPortJson = jObject.getAsJsonArray("hasInPort");
        JsonArray hasOutPortJson = jObject.getAsJsonArray("hasOutPort");
        JsonArray hadEntityJson = jObject.getAsJsonArray("hadEntity");

        JsonArray qualifiedAssociationJson = jObject.getAsJsonArray("qualifiedAssociation");
        JsonArray qualifiedUsageJson = jObject.getAsJsonArray("qualifiedUsage");
        JsonArray qualifiedGenerationJson = jObject.getAsJsonArray("qualifiedGeneration");

        JsonArray associationJson = jObject.getAsJsonArray("association");
        JsonArray usageJson = jObject.getAsJsonArray("usage");
        JsonArray generationJson = jObject.getAsJsonArray("generation");

        for (WorkflowExecution we : workflowExecutionService.findAll()) {
            JsonObject hadPlanJSON = new JsonObject();
            hadPlanJSON.addProperty("association", "e" + we.getId() + "_r" + we.getAuthor().getId());
            hadPlanJSON.addProperty("workflow", we.getWorkflow().getId());
            hadPlanJson.add(hadPlanJSON);

            JsonObject agentAssocJSON = new JsonObject();
            agentAssocJSON.addProperty("association", "e" + we.getId() + "_r" + we.getAuthor().getId());
            agentAssocJSON.addProperty("researcher", we.getAuthor().getId());
            agentRelationJson.add(agentAssocJSON);

            JsonObject qualifieldAssociationJSON = new JsonObject();
            qualifieldAssociationJSON.addProperty("workflowExecution", we.getId());
            qualifieldAssociationJSON.addProperty("association", "e" + we.getId() + "_r" + we.getAuthor().getId());
            qualifiedAssociationJson.add(qualifieldAssociationJSON);

            for (ActivityExecution ae : we.getActivityExecutions()) {
                JsonObject wasPartOfJSON = new JsonObject();
                wasPartOfJSON.addProperty("activityExecution", ae.getId());
                wasPartOfJSON.addProperty("workflowExecution", we.getId());
                wasPartOfAsJson.add(wasPartOfJSON);

                //ASSOCIATION
//            JsonObject wasAssociatedWithJSON = new JsonObject();
//            wasAssociatedWithJSON.addProperty("workflowExecution", we.getId());
//            wasAssociatedWithJSON.addProperty("researcher", we.getAuthor().getId());
//            wasAssociatedWithJson.add(wasAssociatedWithJSON);
                hadPlanJSON = new JsonObject();
                hadPlanJSON.addProperty("association", "e" + ae.getId() + "_r" + ae.getAuthor().getId());
                hadPlanJSON.addProperty("program", ae.getActivity().getId());
                hadPlanJson.add(hadPlanJSON);

                agentAssocJSON = new JsonObject();
                agentAssocJSON.addProperty("association", "e" + ae.getId() + "_r" + ae.getAuthor().getId());
                agentAssocJSON.addProperty("researcher", ae.getAuthor().getId());
                agentRelationJson.add(agentAssocJSON);

                qualifieldAssociationJSON = new JsonObject();
                qualifieldAssociationJSON.addProperty("activityExecution", ae.getId());
                qualifieldAssociationJSON.addProperty("association", "e" + ae.getId() + "_r" + ae.getAuthor().getId());
                qualifiedAssociationJson.add(qualifieldAssociationJSON);

                for (Port input : ae.getInputs()) {
                    JsonObject hasInPortJSON = new JsonObject();
                    hasInPortJSON.addProperty("program", ae.getActivity().getId());
                    hasInPortJSON.addProperty("port", input.getId());
                    hasInPortJson.add(hasInPortJSON);

                    //USAGE                
//                JsonObject generatedJSON = new JsonObject();
//                generatedJSON.addProperty("workflowExecution", ae.getId());
//                switch (p.getEntity().getKind()) {
//                    case DATA:
//                        generatedJSON.addProperty("data", p.getEntity().getId());
//                    case DOCUMENT:
//                        generatedJSON.addProperty("document", p.getEntity().getId());
//                }
//                usedJson.add(generatedJSON);
                    JsonObject hadInPortJSON = new JsonObject();
                    hadInPortJSON.addProperty("usage", "e" + ae.getId() + "_p" + input.getId());
                    hadInPortJSON.addProperty("port", input.getId());
                    hadInPortJson.add(hadInPortJSON);

                    JsonObject hadEntityJSON = new JsonObject();
                    hadEntityJSON.addProperty("usage", "e" + ae.getId() + "_p" + input.getId());
                    switch (input.getEntity().getKind()) {
                        case DATA:
                            hadEntityJSON.addProperty("data", input.getEntity().getId());
                        case DOCUMENT:
                            hadEntityJSON.addProperty("document", input.getEntity().getId());
                    }
                    hadEntityJson.add(hadEntityJSON);

                    JsonObject qualifieldUsageJSON = new JsonObject();
                    qualifieldUsageJSON.addProperty("activityExecution", ae.getId());
                    qualifieldUsageJSON.addProperty("usage", "e" + ae.getId() + "_p" + input.getId());
                    qualifiedUsageJson.add(qualifieldUsageJSON);

                }

                for (Port output : ae.getOutputs()) {
                    JsonObject hasOutPortJSON = new JsonObject();
                    hasOutPortJSON.addProperty("program", ae.getActivity().getId());
                    hasOutPortJSON.addProperty("port", output.getId());
                    hasOutPortJson.add(hasOutPortJSON);

                    //GENERATION
                    JsonObject hadOutPortJSON = new JsonObject();
                    hadOutPortJSON.addProperty("generation", "e" + ae.getId() + "_e" + output.getEntity().getId());
                    hadOutPortJSON.addProperty("port", output.getId());
                    hadOutPortJson.add(hadOutPortJSON);

                    JsonObject hadEntityJSON = new JsonObject();
                    hadEntityJSON.addProperty("generation", "e" + ae.getId() + "_e" + output.getEntity().getId());
                    switch (output.getEntity().getKind()) {
                        case DATA:
                            hadEntityJSON.addProperty("data", output.getEntity().getId());
                        case DOCUMENT:
                            hadEntityJSON.addProperty("document", output.getEntity().getId());
                    }
                    hadEntityJson.add(hadEntityJSON);

                    JsonObject qualifieldGenerationJSON = new JsonObject();
                    qualifieldGenerationJSON.addProperty("activityExecution", ae.getId());
                    qualifieldGenerationJSON.addProperty("generation", "e" + ae.getId() + "_e" + output.getEntity().getId());
                    qualifiedGenerationJson.add(qualifieldGenerationJSON);
                }

            }

        }
    }

}
