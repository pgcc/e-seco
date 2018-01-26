/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.app.service;

import br.ufjf.pgcc.eseco.domain.model.core.Agent;
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

    private JsonObject jObject;

    @Autowired
    public ProvSeOExportDataService(AgentService agentService, CityService cityService, CountryService countryService, DeveloperService developerService, DisciplineService disciplineService, InstitutionService institutionService, InterestService interestService, ResearchGroupService researchGroupService, ResearcherService researcherService, ResearcherKeywordService researcherKeywordService, StateService stateService, ActivityService activityService, ActivityExecutionService activityExecutionService, DataService dataService, DocumentService documentService, EntityService entityService, ExperimentService experimentService, PortService portService, WfmsService wfmsService, WorkflowService workflowService, WorkflowExecutionService workflowExecutionService) {
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
    }

    
    public void getData() {
        jObject = new JsonObject();
        getAgentsData();
        System.out.println(jObject.toString());
    }

    private void getAgentsData() {
        List<Agent> agents = agentService.findAll();
        JsonArray jArray = new JsonArray();
        for (Agent agent : agents) {
            JsonObject agentJSON = new JsonObject();
            agentJSON.addProperty("id", agent.getId());
            agentJSON.addProperty("birthday", agent.getBirthday().toString());
            agentJSON.addProperty("name", agent.getName());
            agentJSON.addProperty("photo", agent.getPhoto());

            jArray.add(agentJSON);
        }
        jObject.add("agents", jArray);
    }

}
