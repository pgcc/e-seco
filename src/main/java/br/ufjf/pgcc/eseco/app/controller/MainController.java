package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.model.Notification;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

@Controller
public class MainController {

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

    @Autowired
    public MainController(AgentService agentService, CityService cityService, CountryService countryService, DeveloperService developerService, DisciplineService disciplineService, InstitutionService institutionService, InterestService interestService, ResearchGroupService researchGroupService, ResearcherService researcherService, ResearcherKeywordService researcherKeywordService, StateService stateService, ActivityService activityService, ActivityExecutionService activityExecutionService, DataService dataService, DocumentService documentService, EntityService entityService, ExperimentService experimentService, PortService portService, WfmsService wfmsService, WorkflowService workflowService, WorkflowExecutionService workflowExecutionService, WorkflowServiceService workflowServiceService) {
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

    @RequestMapping(value = "/")
    public String home(Model model, HttpSession session) {

        // Get important notifications to show
        ArrayList<Notification> importantNotificationsList = new ArrayList<>();
        ArrayList<Notification> notificationsList = (ArrayList<Notification>) session.getAttribute("notifications");
        for (Notification notification : notificationsList) {
            if (notification.isImportant()) {
                importantNotificationsList.add(notification);
            }
        }
        model.addAttribute("chartDataJSON", getChart());
        model.addAttribute("notifications", importantNotificationsList);

        return "home";
    }

    private JSONObject getChart() {

        JSONArray items = new JSONArray();
        JSONObject obj = new JSONObject();
        obj.put("text", "Pesquisadores");
        obj.put("count", researcherService.findAll().size());
        obj.put("link", "/researchers");
        items.add(obj);

        obj = new JSONObject();
        obj.put("text", "Grupos de Pesquisa");
        obj.put("count", researchGroupService.findAll().size());
        obj.put("link", "/researchGroups");
        items.add(obj);

        obj = new JSONObject();
        obj.put("text", "Instituições");
        obj.put("count", institutionService.findAll().size());
        obj.put("link", "/institutions");
        items.add(obj);

        obj = new JSONObject();
        obj.put("text", "Experimentos");
        obj.put("count", experimentService.findAll().size());
        obj.put("link", "/experiments");
        items.add(obj);

        obj = new JSONObject();
        obj.put("text", "Workflows");
        obj.put("count", workflowService.findAll().size());
        obj.put("link", "/experiments/workflows");
        items.add(obj);

        obj = new JSONObject();
        obj.put("text", "Atividades");
        obj.put("count", activityService.findAll().size());
        obj.put("link", "/experiments/activities");
        items.add(obj);

        obj = new JSONObject();
        obj.put("text", "Execução dos Workflows");
        obj.put("count", workflowExecutionService.findAll().size());
        obj.put("link", "/experiments/workflowExecutions");
        items.add(obj);

        obj = new JSONObject();
        obj.put("text", "Execução das Atividades");
        obj.put("count", activityExecutionService.findAll().size());
        obj.put("link", "/experiments/activityExecutions");
        items.add(obj);
        
        obj = new JSONObject();
        obj.put("text", "Entidades");
        obj.put("count", entityService.findAll().size());
        obj.put("link", "/experiments/entities");
        items.add(obj);
        
        obj = new JSONObject();
        obj.put("text", "Proveniência");
        obj.put("count", 1);
        obj.put("link", "/ontology/experiment_1");
        items.add(obj);
        
        obj = new JSONObject();
        obj.put("text", "Protocolo");
        obj.put("count", 1);
        obj.put("link", "/experiments/1");
        items.add(obj);
        
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("items", items);
        return jsonObject;
    }
}
