package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.biocatalogue.exception.BioCatalogueException;
import br.ufjf.pgcc.eseco.app.model.WorkflowServiceSearchResult;
import br.ufjf.pgcc.eseco.app.service.BioCatalogueService;
import br.ufjf.pgcc.eseco.domain.model.analysis.ReseacherRelevance;
import br.ufjf.pgcc.eseco.domain.model.context.WorkflowServiceContextModel;
import br.ufjf.pgcc.eseco.domain.model.context.WorkflowServiceRatingContextModel;
import br.ufjf.pgcc.eseco.domain.model.core.Agent;
import br.ufjf.pgcc.eseco.domain.model.core.Developer;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import br.ufjf.pgcc.eseco.domain.model.experiment.Activity;
import br.ufjf.pgcc.eseco.domain.model.experiment.Experiment;
import br.ufjf.pgcc.eseco.domain.model.experiment.Workflow;
import br.ufjf.pgcc.eseco.domain.model.resource.*;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.analysis.ResearcherRelevanceService;
import br.ufjf.pgcc.eseco.domain.service.resource.*;
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
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
public class ComponentsController {

    private static final int DETAIL_PLUGIN = 1;
    private static final int DETAIL_WORKFLOW_SERVICE_INTERNAL = 2;
    private static final int DETAIL_WORKFLOW_SERVICE_EXTERNAL_BIOCATALOGUE = 3;

    private ComponentService componentService;
    private ComponentTypeService componentTypeService;
    private WorkflowServiceService workflowServiceService;
    private BioCatalogueService bioCatalogueService;
    private WorkflowServiceContextModelService workflowServiceContextModelService;
    private WorkflowServiceRatingContextModelService workflowServiceRatingContextModelService;
    private ResearcherService researcherService;
    private ResearcherRelevanceService researcherRelevanceService;
    private WorkflowServiceRatingInvitationService workflowServiceRatingInvitationService;
    private WorkflowServiceRatingService workflowServiceRatingService;
    private WorkflowServiceCommentService workflowServiceCommentService;

    @Autowired
    public ComponentsController(ComponentService componentService,
                                ComponentTypeService componentTypeService,
                                WorkflowServiceService workflowServiceService,
                                BioCatalogueService bioCatalogueService,
                                WorkflowServiceContextModelService workflowServiceContextModelService,
                                WorkflowServiceRatingContextModelService workflowServiceRatingContextModelService,
                                ResearcherService researcherService,
                                ResearcherRelevanceService researcherRelevanceService,
                                WorkflowServiceRatingInvitationService workflowServiceRatingInvitationService,
                                WorkflowServiceRatingService workflowServiceRatingService,
                                WorkflowServiceCommentService workflowServiceCommentService) {
        this.componentService = componentService;
        this.componentTypeService = componentTypeService;
        this.workflowServiceService = workflowServiceService;
        this.bioCatalogueService = bioCatalogueService;
        this.workflowServiceContextModelService = workflowServiceContextModelService;
        this.workflowServiceRatingContextModelService = workflowServiceRatingContextModelService;
        this.researcherService = researcherService;
        this.researcherRelevanceService = researcherRelevanceService;
        this.workflowServiceRatingInvitationService = workflowServiceRatingInvitationService;
        this.workflowServiceRatingService = workflowServiceRatingService;
        this.workflowServiceCommentService = workflowServiceCommentService;
    }

    @RequestMapping(value = "/components")
    public String overview() {
        return "components/overview";
    }


    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // COMPONENTS DETAILS                                                                                            //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    @RequestMapping(value = "/components/details/{type}/{id}")
    public String serviceDetails(Model model, HttpServletRequest request,
                                 @PathVariable(value = "type") int type,
                                 @PathVariable(value = "id") int id) throws ClassNotFoundException {

        model.addAttribute("type", type);

        // Get Session
        HttpSession session = request.getSession();

        if (null != session.getAttribute("comment_inserted")) {
            model.addAttribute("comment_inserted", true);
            session.removeAttribute("comment_inserted");
        }

        if (null != session.getAttribute("comment_rated")) {
            model.addAttribute("comment_rated", true);
            session.removeAttribute("comment_rated");
        }

        switch (type) {
            case DETAIL_PLUGIN:
            case DETAIL_WORKFLOW_SERVICE_INTERNAL:
                Component component = componentService.find(id);
                if (null != component) {
                    // Create context info for this component
                    WorkflowServiceContextModel componentContextInfo = null;
                    try {
                        componentContextInfo = workflowServiceContextModelService.createModelInfo(component);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    // Prepare for transformation (reduce the object to avoid stack overflow from gson)
                    List<WorkflowServiceContextModel> usedEsecoWorkflowServicesList = new ArrayList<>();
                    List<Activity> activitiesList = new ArrayList<>();
                    List<Workflow> workflowsList = new ArrayList<>();
                    List<Experiment> experimentsList = new ArrayList<>();
                    List<Researcher> researchersList = new ArrayList<>();
                    List<WorkflowServiceRating> ratingsList = new ArrayList<>();
                    List<WorkflowServiceComment> commentsList = new ArrayList<>();
                    List<WorkflowServiceComment> rootCommentsList = new ArrayList<>();

                    if (componentContextInfo != null) {
                        usedEsecoWorkflowServicesList = componentContextInfo.getUsedEsecoWorkflowServicesList();
                        componentContextInfo.setUsedEsecoWorkflowServicesList(null);

                        activitiesList = componentContextInfo.getActivitiesUsing();
                        componentContextInfo.setActivitiesUsing(null);

                        workflowsList = componentContextInfo.getWorkflowsUsing();
                        componentContextInfo.setWorkflowsUsing(null);

                        experimentsList = componentContextInfo.getExperimentsUsing();
                        componentContextInfo.setExperimentsUsing(null);

                        researchersList = componentContextInfo.getResearchersUsing();
                        componentContextInfo.setResearchersUsing(null);

                        for(WorkflowServiceRating workflowServiceRating : componentContextInfo.getWsRatings()){
                            if(workflowServiceRating.getType() == 2){
                                ratingsList.add(workflowServiceRating);
                            }
                        }
                        componentContextInfo.setWsRatings(null);

                        commentsList = componentContextInfo.getWsComments();
                        componentContextInfo.setWsComments(null);
                    }

                    // Comments
                    for (WorkflowServiceComment comment : commentsList) {
                        if (comment.getParent() == null) {
                            rootCommentsList.add(comment);
                        }
                    }

                    // Transform context info into JSON String
                    Gson gson = new GsonBuilder().create();
                    String componentContextInfoJSON = gson.toJson(componentContextInfo);

                    model.addAttribute("component", component);
                    model.addAttribute("componentContextInfo", componentContextInfo);
                    model.addAttribute("componentContextInfoJSON", componentContextInfoJSON);
                    model.addAttribute("usedEsecoWorkflowServicesList", usedEsecoWorkflowServicesList);
                    model.addAttribute("activitiesList", activitiesList);
                    model.addAttribute("workflowsList", workflowsList);
                    model.addAttribute("experimentsList", experimentsList);
                    model.addAttribute("researchersList", researchersList);
                    model.addAttribute("ratingsList", ratingsList);
                    model.addAttribute("commentsList", commentsList);
                    model.addAttribute("rootCommentsList", rootCommentsList);
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
                        if (wsr.getType() == 1) {
                            try {
                                workflowServiceRatingContextInfo.add(workflowServiceRatingContextModelService.createModelInfo(wsr));
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
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

    @RequestMapping(value = "/components/actions/register")
    public String actionsRegister() {
        return "components/actions-register";
    }

    @RequestMapping(value = "/components/actions/register", method = RequestMethod.POST)
    public String actionsRegisterPost(Model model, HttpServletRequest request) {
        String name = request.getParameter("component-name");
        String type = request.getParameter("component-type");
        String documentation = request.getParameter("component-documentation");
        String wsInternalClass = request.getParameter("ws-internal_class");
        String wsType = request.getParameter("ws-type");
        String wsUrl = request.getParameter("ws-url");
        String wsDescription = request.getParameter("ws-description");

        // PLUGIN
        if (type.equals("1")) {


        // WORKFLOW SERVICE
        } else if (type.equals("2")) {

            // Get Session
            HttpSession session = request.getSession();

            // Get Logged User from Session
            User user = (User) session.getAttribute("logged_user");

            // Get User Agent
            Agent agent = user.getAgent();

            ComponentType componentType = componentTypeService.find(Integer.parseInt(type));

            Component component = new Component();
            component.setName(name);
            component.setType(componentType);
            component.setAuthor(agent.getDeveloper());
            component.setDateCreated(new Date());
            if (!documentation.equals("")) {
                component.setDocumentationUrl(documentation);
            }

            try {
                component = componentService.add(component);

                WorkflowService workflowService = new WorkflowService();
                workflowService.setInternalClass(wsInternalClass);
                workflowService.setType(wsType);
                workflowService.setUrl(wsUrl);
                workflowService.setDescription(wsDescription);
                workflowService.setComponent(component);

                workflowService = workflowServiceService.add(workflowService);

                return "redirect:/components/details/2/" + component.getId();

            } catch (Exception e) {
                e.printStackTrace();
            }

        } else {
            model.addAttribute("error", "Invalid Component Type");
        }

        return "components/actions-register";
    }

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
            componentContextInfo.setWsComments(null);

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
            WorkflowService workflowService = component.getWorkflowService();
            model.addAttribute("component", component);
            model.addAttribute("workflowService", workflowService);
        }

        // Get most indicated reseachers for invitation
        List<ReseacherRelevance> reseacherRelevanceList = null;
        try {
            reseacherRelevanceList = researcherRelevanceService.analyseReseachersForWorkflowService(component);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (null != reseacherRelevanceList) {
            Collections.sort(reseacherRelevanceList, new Comparator<ReseacherRelevance>() {
                @Override
                public int compare(ReseacherRelevance rr1, ReseacherRelevance rr2) {
                    if (rr1.getRelevance() > rr2.getRelevance()) {
                        return -1;
                    } else if (rr1.getRelevance() < rr2.getRelevance()) {
                        return 1;
                    }
                    return 0;
                }
            });
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

        // Get Session
        HttpSession session = request.getSession();

        // Get Logged User from Session
        User userOnSession = (User) session.getAttribute("logged_user");
        Developer developer = userOnSession.getAgent().getDeveloper();

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
                workflowServiceService.inviteResearcherForRating(component.getWorkflowService(), researcher, datechat, developer);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        model.addAttribute("totalInvitations", totalInvitations);

        return "components/actions-workflow-services-invite-rating-result";
    }

    @RequestMapping(value = "/components/actions/workflow-services/comment/{id}", method = RequestMethod.POST)
    public String actionsWorkflowServicesCommentPost(Model model,
                                                     @PathVariable(value = "id") int id,
                                                     HttpServletRequest request) {

        Component component = componentService.find(id);
        if (null == component) {
            return "";
        }

        model.addAttribute("component", component);

        String submitComment = request.getParameter("submit-comment");
        String submitCommentReply = request.getParameter("submit-comment-reply");
        String content = request.getParameter("comment-content");
        String reply = request.getParameter("comment-reply");
        String replyTo = request.getParameter("comment-reply-to");

        // Get Session
        HttpSession session = request.getSession();

        // Get Logged User from Session
        User user = (User) session.getAttribute("logged_user");

        // Get User Agent
        Agent agent = user.getAgent();

        // Register the comment
        try {
            WorkflowServiceComment workflowServiceCommentParent = null;
            if (submitCommentReply != null) {
                workflowServiceCommentParent = workflowServiceCommentService.find(Integer.parseInt(replyTo));
                if (null != workflowServiceCommentParent) {
                    content = reply;
                }
            }

            WorkflowServiceComment workflowServiceComment = workflowServiceCommentService.registerComment(agent, component.getWorkflowService(), content, workflowServiceCommentParent);
        } catch (Exception e) {
            e.printStackTrace();
        }

        session.setAttribute("comment_inserted", true);
        return "redirect:/components/details/" + component.getType().getId() + "/" + component.getId();
    }

    @RequestMapping(value = "/components/actions/workflow-services/comment/{id}/rate", method = RequestMethod.POST)
    public @ResponseBody
    String actionsWorkflowServicesCommentRatePost(Model model,
                                                  @PathVariable(value = "id") int id,
                                                  HttpServletRequest request) {
        Component component = componentService.find(id);
        if (null == component) {
            return "error";
        }

        model.addAttribute("component", component);

        String commentId = request.getParameter("rd-comment-id");
        String stars = request.getParameter("rd-stars");

        // Get Session
        HttpSession session = request.getSession();

        // Get Logged User from Session
        User user = (User) session.getAttribute("logged_user");

        // Get User Agent
        Agent agent = user.getAgent();

        // get comment
        WorkflowServiceComment workflowServiceComment = workflowServiceCommentService.find(Integer.parseInt(commentId));

        switch (stars) {
            case "1":
                workflowServiceComment.setRateStar1(workflowServiceComment.getRateStar1() + 1);
                break;
            case "2":
                workflowServiceComment.setRateStar2(workflowServiceComment.getRateStar2() + 1);
                break;
            case "3":
                workflowServiceComment.setRateStar3(workflowServiceComment.getRateStar3() + 1);
                break;
            case "4":
                workflowServiceComment.setRateStar4(workflowServiceComment.getRateStar4() + 1);
                break;
            case "5":
                workflowServiceComment.setRateStar5(workflowServiceComment.getRateStar5() + 1);
                break;
        }

        try {
            workflowServiceCommentService.update(workflowServiceComment);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return workflowServiceComment.getRateStarsAverage().toString();
    }

    @RequestMapping(value = "/components/actions/workflow-services/rating")
    public String actionsWorkflowServicesRating(Model model, HttpServletRequest request) {
        // Get Session
        HttpSession session = request.getSession();

        // Get Logged User from Session
        User user = (User) session.getAttribute("logged_user");

        // Get Researcher
        Researcher researcher = researcherService.find(user.getAgent().getResearcher().getId());

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
            if (workflowServiceRatingInvitation.isCompleted()) {
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
        if (request.getParameter("approved").equals("1")) {
            approved = true;
        } else if (request.getParameter("approved").equals("0")) {
            approved = false;
        }

        String reprovedText = request.getParameter("text-reproved");

        WorkflowServiceRating workflowServiceRating = new WorkflowServiceRating();
        workflowServiceRating.setWorkflowService(workflowServiceRatingInvitation.getWorkflowService());
        workflowServiceRating.setRater(workflowServiceRatingInvitation.getRater().getAgent());
        workflowServiceRating.setType(2); // Type 2 == Researcher Rating
        workflowServiceRating.setDate(new Date());
        workflowServiceRating.setApproved(approved);
        if (!approved) {
            workflowServiceRating.setReprovedText(reprovedText);
        }

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


    @RequestMapping(value = "/components/actions/workflow-services/developer-rating/{id}")
    public String actionsWorkflowServicesDeveloperRating(Model model,
                                                         @PathVariable(value = "id") int id,
                                                         HttpServletRequest request) {

        Component component = componentService.find(id);
        WorkflowService workflowService = component.getWorkflowService();

        if (null == workflowService) {
            return null;
        }

        model.addAttribute("workflowService", workflowService);

        return "components/actions-workflow-services-rating-developer-form";
    }

    @RequestMapping(value = "/components/actions/workflow-services/developer-rating/{id}", method = RequestMethod.POST)
    public String actionsWorkflowServicesDeveloperRatingPost(Model model,
                                                             @PathVariable(value = "id") int id,
                                                             HttpServletRequest request) {

        Component component = componentService.find(id);
        WorkflowService workflowService = component.getWorkflowService();

        if (null == workflowService) {
            return null;
        }

        model.addAttribute("workflowService", workflowService);

        // Get Session
        HttpSession session = request.getSession();

        // Get Logged User from Session
        User user = (User) session.getAttribute("logged_user");

        // Get User Agent
        Agent agent = user.getAgent();

        String documentation = request.getParameter("documentation");
        String ease_of_use = request.getParameter("ease_of_use");
        String performance = request.getParameter("performance");
        String reliability = request.getParameter("reliability");
        String disponibility = request.getParameter("disponibility");

        WorkflowServiceRating workflowServiceRating = new WorkflowServiceRating();
        workflowServiceRating.setWorkflowService(workflowService);
        workflowServiceRating.setRater(agent);
        workflowServiceRating.setType(1); // Type 1 == Developer Rating
        workflowServiceRating.setDate(new Date());
        workflowServiceRating.setValueDocumentation(Integer.parseInt(documentation));
        workflowServiceRating.setValueEaseOfUse(Integer.parseInt(ease_of_use));
        workflowServiceRating.setValuePerformance(Integer.parseInt(performance));
        workflowServiceRating.setValueReliability(Integer.parseInt(reliability));
        workflowServiceRating.setValueDisponibility(Integer.parseInt(disponibility));

        try {
            workflowServiceRatingService.add(workflowServiceRating);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "components/actions-workflow-services-rating-developer-form-result";
    }


    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // COMPONENTS COMPOSITIONS                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    @RequestMapping(value = "/components/compositions/workflow-services")
    public String compositionsWorkflowServices() {
        return "components/compositions-workflow-services";
    }

}