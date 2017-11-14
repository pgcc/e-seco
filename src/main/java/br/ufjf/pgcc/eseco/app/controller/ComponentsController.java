package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.biocatalogue.exception.BioCatalogueException;
import br.ufjf.pgcc.eseco.app.model.WorkflowServiceSearchResult;
import br.ufjf.pgcc.eseco.app.service.BioCatalogueService;
import br.ufjf.pgcc.eseco.domain.model.analysis.ReseacherRelevance;
import br.ufjf.pgcc.eseco.domain.model.context.WorkflowServiceContextModel;
import br.ufjf.pgcc.eseco.domain.model.context.WorkflowServiceRatingContextModel;
import br.ufjf.pgcc.eseco.domain.model.core.Agent;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import br.ufjf.pgcc.eseco.domain.model.experiment.Activity;
import br.ufjf.pgcc.eseco.domain.model.experiment.Experiment;
import br.ufjf.pgcc.eseco.domain.model.experiment.Workflow;
import br.ufjf.pgcc.eseco.domain.model.resource.Component;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowService;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowServiceRating;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowServiceRatingInvitation;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.analysis.ResearcherRelevanceService;
import br.ufjf.pgcc.eseco.domain.service.resource.ComponentService;
import br.ufjf.pgcc.eseco.domain.service.resource.WorkflowServiceRatingInvitationService;
import br.ufjf.pgcc.eseco.domain.service.resource.WorkflowServiceRatingService;
import br.ufjf.pgcc.eseco.domain.service.resource.WorkflowServiceService;
import br.ufjf.pgcc.eseco.domain.service.context.WorkflowServiceContextModelService;
import br.ufjf.pgcc.eseco.domain.service.context.WorkflowServiceRatingContextModelService;
import br.ufjf.pgcc.eseco.domain.service.core.ResearcherService;
import com.google.gson.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class ComponentsController {

    private static final int DETAIL_PLUGIN = 1;
    private static final int DETAIL_WORKFLOW_SERVICE_INTERNAL = 2;
    private static final int DETAIL_WORKFLOW_SERVICE_EXTERNAL_BIOCATALOGUE = 3;

    private ComponentService componentService;
    private WorkflowServiceService workflowServiceService;
    private BioCatalogueService bioCatalogueService;
    private WorkflowServiceContextModelService workflowServiceContextModelService;
    private WorkflowServiceRatingContextModelService workflowServiceRatingContextModelService;
    private ResearcherService researcherService;
    private ResearcherRelevanceService researcherRelevanceService;
    private WorkflowServiceRatingInvitationService workflowServiceRatingInvitationService;
    private WorkflowServiceRatingService workflowServiceRatingService;

    @Autowired
    public ComponentsController(ComponentService componentService, WorkflowServiceService workflowServiceService,
                                BioCatalogueService bioCatalogueService,
                                WorkflowServiceContextModelService workflowServiceContextModelService,
                                WorkflowServiceRatingContextModelService workflowServiceRatingContextModelService,
                                ResearcherService researcherService,
                                ResearcherRelevanceService researcherRelevanceService,
                                WorkflowServiceRatingInvitationService workflowServiceRatingInvitationService,
                                WorkflowServiceRatingService workflowServiceRatingService) {
        this.componentService = componentService;
        this.workflowServiceService = workflowServiceService;
        this.bioCatalogueService = bioCatalogueService;
        this.workflowServiceContextModelService = workflowServiceContextModelService;
        this.workflowServiceRatingContextModelService = workflowServiceRatingContextModelService;
        this.researcherService = researcherService;
        this.researcherRelevanceService = researcherRelevanceService;
        this.workflowServiceRatingInvitationService = workflowServiceRatingInvitationService;
        this.workflowServiceRatingService = workflowServiceRatingService;
    }

    @RequestMapping(value = "/components")
    public String overview() {
        return "components/overview";
    }


    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // COMPONENTS DETAILS                                                                                            //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    @RequestMapping(value = "/components/details/{type}/{id}")
    public String serviceDetails(Model model,
                                 @PathVariable(value = "type") int type,
                                 @PathVariable(value = "id") int id) throws ClassNotFoundException {

        model.addAttribute("type", type);

        switch (type) {
            case DETAIL_PLUGIN:
            case DETAIL_WORKFLOW_SERVICE_INTERNAL:
                Component component = componentService.find(id);
                if (null != component) {
                    // Create context info for this resource
                    WorkflowServiceContextModel componentContextInfo = null;
                    try {
                        componentContextInfo = workflowServiceContextModelService.createModelInfo(component);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    // Prepare for transformation (reduce the object to avoid stack overflow from gson)
                    List<Activity> activitiesList = new ArrayList<>();
                    List<Workflow> workflowsList = new ArrayList<>();
                    List<Experiment> experimentsList = new ArrayList<>();
                    List<Researcher> researchersList = new ArrayList<>();
                    List<WorkflowServiceRating> ratingsList = new ArrayList<>();

                    if (componentContextInfo != null) {
                        activitiesList = componentContextInfo.getActivitiesUsing();
                        componentContextInfo.setActivitiesUsing(null);

                        workflowsList = componentContextInfo.getWorkflowsUsing();
                        componentContextInfo.setWorkflowsUsing(null);

                        experimentsList = componentContextInfo.getExperimentsUsing();
                        componentContextInfo.setExperimentsUsing(null);

                        researchersList = componentContextInfo.getResearchersUsing();
                        componentContextInfo.setResearchersUsing(null);

                        ratingsList = componentContextInfo.getWsRatings();
                        componentContextInfo.setWsRatings(null);
                    }

                    // Transform context info into JSON String
                    Gson gson = new GsonBuilder().create();
                    String componentContextInfoJSON = gson.toJson(componentContextInfo);

                    model.addAttribute("component", component);
                    model.addAttribute("componentContextInfo", componentContextInfo);
                    model.addAttribute("componentContextInfoJSON", componentContextInfoJSON);
                    model.addAttribute("activitiesList", activitiesList);
                    model.addAttribute("workflowsList", workflowsList);
                    model.addAttribute("experimentsList", experimentsList);
                    model.addAttribute("researchersList", researchersList);
                    model.addAttribute("ratingsList", ratingsList);
                }
                break;

            case DETAIL_WORKFLOW_SERVICE_EXTERNAL_BIOCATALOGUE:
                // @TODO: BIOCATALOGUE: get result from biocatalogue service getDetails
                break;
        }

        return "components/details";
    }

    @RequestMapping(value = "/components/details/{type}/{id}/ratings-visualization")
    public String serviceDetailsRatingsVisualization(Model model,
                                                     @PathVariable(value = "type") int type,
                                                     @PathVariable(value = "id") int id) throws ClassNotFoundException {

        model.addAttribute("type", type);

        if (type == DETAIL_WORKFLOW_SERVICE_INTERNAL) {
            Component component = componentService.find(id);
            if (null != component) {
                // Create context info for this resource
                WorkflowServiceContextModel componentContextInfo = null;
                try {
                    componentContextInfo = workflowServiceContextModelService.createModelInfo(component);
                } catch (Exception e) {
                    e.printStackTrace();
                }

                if (componentContextInfo != null) {
                    // Create context model for ratings
                    List<WorkflowServiceRatingContextModel> workflowServiceRatingContextInfo = new ArrayList<>();
                    for (WorkflowServiceRating wsr : componentContextInfo.getWsRatings()) {
                        try {
                            workflowServiceRatingContextInfo.add(workflowServiceRatingContextModelService.createModelInfo(wsr));
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }

                    // Transform context info into JSON String
                    Gson gson = new GsonBuilder().create();
                    String workflowServiceRatingContextInfoJSON = gson.toJson(workflowServiceRatingContextInfo);

                    model.addAttribute("component", component);
                    model.addAttribute("componentContextInfo", componentContextInfo);
                    model.addAttribute("workflowServiceRatingContextInfoJSON", workflowServiceRatingContextInfoJSON);
                }
            }
        }

        return "components/details-ratings-visualization";
    }


    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // COMPONENTS EXPLORERS                                                                                          //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    @RequestMapping(value = "/components/plugins")
    public String plugins() {
        return "components/explore-plugins";
    }

    @RequestMapping(value = "/components/workflow-services/internal")
    public String workflowServicesInternal(Model model) {

        List<WorkflowService> services_workflow_list = workflowServiceService.findAll();

        model.addAttribute("services_workflow_list", services_workflow_list);

        return "components/explore-workflow-services-internal";
    }

    @RequestMapping(value = "/components/workflow-services/external")
    public String workflowServicesExternal() {
        return "components/explore-workflow-services-external";
    }

    @RequestMapping(value = "/components/workflow-services/search", method = RequestMethod.POST)
    public String workflowServicesSearch(Model model, HttpServletRequest request) {

        String searchQuery = request.getParameter("search_string");

        ArrayList<WorkflowServiceSearchResult> searchResults = null;

        // Search in BioCatalogue
        try {
            searchResults = bioCatalogueService.search(searchQuery, "services");

        } catch (BioCatalogueException e) {
            e.printStackTrace();
        }

        model.addAttribute("searchString", searchQuery);
        model.addAttribute("searchResults", searchResults);

        return "components/explore-workflow-services-external";
    }


    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // COMPONENTS ACTIONS                                                                                            //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    @RequestMapping(value = "/components/actions/workflow-services/compare")
    public String actionsWorkflowServicesCompare(Model model, HttpServletRequest request) {
        String ids = request.getParameter("actions-ids");
        String[] idsList = ids.split(",");

        ArrayList<WorkflowServiceContextModel> componentsContextModelList = new ArrayList<>();

        for (String id : idsList) {
            Component component = componentService.find(Integer.parseInt(id));

            // Create context info for this resource
            WorkflowServiceContextModel componentContextInfo = null;
            try {
                componentContextInfo = workflowServiceContextModelService.createModelInfo(component);
            } catch (Exception e) {
                e.printStackTrace();
            }

            // Prepare for transformation (reduce the object to avoid stack overflow from gson)
            componentContextInfo.setActivitiesUsing(null);
            componentContextInfo.setWorkflowsUsing(null);
            componentContextInfo.setExperimentsUsing(null);
            componentContextInfo.setResearchersUsing(null);
            componentContextInfo.setWsRatings(null);

            componentsContextModelList.add(componentContextInfo);
        }

        // Transform List into JSON String
        Gson gson = new GsonBuilder().create();
        String componentsContextInfoJSON = gson.toJson(componentsContextModelList);

        model.addAttribute("componentsContextInfo", componentsContextInfoJSON);

        return "components/actions-workflow-services-compare";
    }

    @RequestMapping(value = "/components/actions/workflow-services/invite-rating/{id}")
    public String actionsWorkflowServicesInviteRating(Model model,
                                                      @PathVariable(value = "id") int id,
                                                      HttpServletRequest request) {

        Component component = componentService.find(id);
        if (null != component) {
            model.addAttribute("component", component);
        }

        // Get most indicated reseachers for invitation
        List<ReseacherRelevance> reseacherRelevanceList = null;
        try {
            reseacherRelevanceList = researcherRelevanceService.analyseReseachersForWorkflowService(component);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Transform data info into JSON String
        Gson gson = new GsonBuilder().create();
        String reseacherRelevanceListJSON = gson.toJson(reseacherRelevanceList);

        model.addAttribute("reseacherRelevanceList", reseacherRelevanceList);
        model.addAttribute("reseacherRelevanceListJSON", reseacherRelevanceListJSON);

        return "components/actions-workflow-services-invite-rating";
    }

    @RequestMapping(value = "/components/actions/workflow-services/invite-rating/{id}", method = RequestMethod.POST)
    public String actionsWorkflowServicesInviteRatingPost(Model model,
                                                          @PathVariable(value = "id") int id,
                                                          HttpServletRequest request) {

        Component component = componentService.find(id);
        if (null == component) {
            return "";
        }

        model.addAttribute("component", component);

        String datechat = request.getParameter("datechat");
        String ids = request.getParameter("actions-ids");
        String[] idsList = ids.split(",");

        int totalInvitations = 0;

        for (String researcherIdString : idsList) {
            int researcherId = Integer.parseInt(researcherIdString);
            totalInvitations++;
            Researcher researcher = researcherService.find(researcherId);

            // Send Invitation
            try {
                workflowServiceService.inviteResearcherForRating(component.getWorkflowService(), researcher, datechat);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        model.addAttribute("totalInvitations", totalInvitations);

        return "components/actions-workflow-services-invite-rating-result";
    }

    @RequestMapping(value = "/components/actions/workflow-services/rating")
    public String actionsWorkflowServicesRating(Model model, HttpServletRequest request) {
        // Get Session
        HttpSession session = request.getSession();

        // Get Logged User from Session
        User user = (User) session.getAttribute("logged_user");

        // Get Researcher
        Researcher researcher = researcherService.find(user.getAgent().getId());

        List<WorkflowServiceRatingInvitation> workflowServiceRatingInvitationListOpen = new ArrayList<>();
        List<WorkflowServiceRatingInvitation> workflowServiceRatingInvitationListCompleted = new ArrayList<>();

        for (WorkflowServiceRatingInvitation wfri : researcher.getWorkflowServiceRatingInvitations()) {
            if (wfri.isCompleted()) {
                workflowServiceRatingInvitationListCompleted.add(wfri);
            } else {
                workflowServiceRatingInvitationListOpen.add(wfri);
            }
        }

        model.addAttribute("workflowServiceRatingInvitationListOpen", workflowServiceRatingInvitationListOpen);
        model.addAttribute("workflowServiceRatingInvitationListCompleted", workflowServiceRatingInvitationListCompleted);

        return "components/actions-workflow-services-rating";
    }

    @RequestMapping(value = "/components/actions/workflow-services/rating/{id}")
    public String actionsWorkflowServicesRating(Model model,
                                                @PathVariable(value = "id") int id,
                                                HttpServletRequest request) {

        WorkflowServiceRatingInvitation workflowServiceRatingInvitation = workflowServiceRatingInvitationService.find(id);

        if (null != workflowServiceRatingInvitation) {
            if(workflowServiceRatingInvitation.isCompleted()){
                return "redirect:/components/actions/workflow-services/rating";
            }

            model.addAttribute("invitation", workflowServiceRatingInvitation);
        }

        return "components/actions-workflow-services-rating-form";
    }

    @RequestMapping(value = "/components/actions/workflow-services/rating/{id}", method = RequestMethod.POST)
    public String actionsWorkflowServicesRatingPost(Model model,
                                                @PathVariable(value = "id") int id,
                                                HttpServletRequest request) {

        WorkflowServiceRatingInvitation workflowServiceRatingInvitation = workflowServiceRatingInvitationService.find(id);

        if (null == workflowServiceRatingInvitation) {
            return null;
        }

        model.addAttribute("invitation", workflowServiceRatingInvitation);

        boolean approved = false;
        if(null != request.getParameter("approved")){
            approved = true;
        }
        String documentation = request.getParameter("documentation");
        String ease_of_use = request.getParameter("ease_of_use");
        String performance = request.getParameter("performance");
        String reliability = request.getParameter("reliability");
        String disponibility = request.getParameter("disponibility");

        WorkflowServiceRating workflowServiceRating = new WorkflowServiceRating();
        workflowServiceRating.setWorkflowService(workflowServiceRatingInvitation.getWorkflowService());
        workflowServiceRating.setRater(workflowServiceRatingInvitation.getRater());
        workflowServiceRating.setDate(new Date());
        workflowServiceRating.setApproved(approved);
        workflowServiceRating.setValueDocumentation(Integer.parseInt(documentation));
        workflowServiceRating.setValueEaseOfUse(Integer.parseInt(ease_of_use));
        workflowServiceRating.setValuePerformance(Integer.parseInt(performance));
        workflowServiceRating.setValueReliability(Integer.parseInt(reliability));
        workflowServiceRating.setValueDisponibility(Integer.parseInt(disponibility));

        try {
            workflowServiceRatingInvitation.setCompleted(true);
            workflowServiceRatingInvitation.setDateCompleted(new Date());
            workflowServiceRatingInvitationService.update(workflowServiceRatingInvitation);
            workflowServiceRatingService.add(workflowServiceRating);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "components/actions-workflow-services-rating-form-result";
    }


    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // COMPONENTS COMPOSITIONS                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    @RequestMapping(value = "/components/compositions/workflow-services")
    public String compositionsWorkflowServices() {
        return "components/compositions-workflow-services";
    }

}