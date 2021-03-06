package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.validator.ExperimentWorkflowFormValidator;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import br.ufjf.pgcc.eseco.domain.model.experiment.Activity;
import br.ufjf.pgcc.eseco.domain.model.experiment.Experiment;
import br.ufjf.pgcc.eseco.domain.model.experiment.Wfms;
import br.ufjf.pgcc.eseco.domain.model.experiment.Workflow;
import br.ufjf.pgcc.eseco.domain.model.experiment.WorkflowActivity;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.experiment.ActivityService;
import br.ufjf.pgcc.eseco.domain.service.experiment.ExperimentService;
import br.ufjf.pgcc.eseco.domain.service.experiment.WfmsService;
import br.ufjf.pgcc.eseco.domain.service.experiment.WorkflowService;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@SessionAttributes({"workflowForm"})
public class ExperimentWorkflowsController {

    private static final Logger LOGGER = Logger.getLogger(ExperimentWorkflowsController.class.getName());

    @Autowired
    ExperimentWorkflowFormValidator workflowFormValidator;

    private ExperimentService experimentService;
    private WorkflowService workflowService;
    private WfmsService wfmsService;
    private ActivityService activityService;

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(workflowFormValidator);
    }

    @Autowired
    public void setWorkflowService(ExperimentService experimentService, WorkflowService workflowService,
            WfmsService wfmsService, ActivityService activityService) {
        this.experimentService = experimentService;
        this.workflowService = workflowService;
        this.wfmsService = wfmsService;
        this.activityService = activityService;
    }

    @RequestMapping(value = "/experiments/workflows", method = RequestMethod.GET)
    public String showAllWorkflows(Model model, HttpSession session) {

        LOGGER.info("showAllWorkflows()");

        ArrayList<Workflow> myworkflows = new ArrayList<>();
        ArrayList<Workflow> workflows = new ArrayList<>();

        User user = (User) session.getAttribute("logged_user");
        for (Workflow w : workflowService.findAll()) {
            if (w.getAuthor().getId() == user.getAgent().getResearcher().getId()) {
                myworkflows.add(w);
            } else {
                workflows.add(w);
            }
        }

        model.addAttribute("myworkflows", myworkflows);
        model.addAttribute("workflows", workflows);

        model.addAttribute("workflows", workflowService.findAll());

        return "experiments/workflows/list";

    }

    @RequestMapping(value = "/experiments/{id}/workflows/add", method = RequestMethod.GET)
    public String showAddWorkflowForm(@PathVariable("id") int experimentId, Model model, HttpSession session) {
        LOGGER.info("showAddWorkflowForm()");

        Workflow workflow = new Workflow();

        // set default value
        User user = (User) session.getAttribute("logged_user");
        workflow.setAuthor(user.getAgent().getResearcher());
        if (experimentId != 0) {
            Experiment experiment = experimentService.find(experimentId);
            ArrayList<Experiment> experiments = new ArrayList<>();
            experiments.add(experiment);
            workflow.setExperiments(experiments);
        }
        workflow.setDateCreated(new Date());
        workflow.setVersion("1.0.0");
        workflow.setWfms(wfmsService.find(5));
        Collections.sort(workflow.getActivities());

        model.addAttribute("workflowForm", workflow);
        populateDefaultModel(model, user.getAgent().getResearcher());

        return "experiments/workflows/workflows-form";
    }

    @RequestMapping(value = "/experiments/workflows/add", method = RequestMethod.GET)
    public String showAddWorkflowForm(Model model, HttpSession session) {

        LOGGER.info("showAddWorkflowForm()");

        Workflow workflow = new Workflow();

        // set default value
        User user = (User) session.getAttribute("logged_user");
        workflow.setAuthor(user.getAgent().getResearcher());
        workflow.setDateCreated(new Date());
        workflow.setVersion("1.0.0");
        Wfms wfms = new Wfms();
        workflow.setWfms(wfms);
        Collections.sort(workflow.getActivities());

        model.addAttribute("workflowForm", workflow);
        populateDefaultModel(model, user.getAgent().getResearcher());

        return "experiments/workflows/workflows-form";
    }

    @RequestMapping(value = "/experiments/workflows/{id}/addActivities", method = RequestMethod.POST)
    public String addActivities(@ModelAttribute("workflowForm") Workflow workflow, @PathVariable("id") int id, @RequestParam("ids") String ids, Model model, HttpSession session) {

        LOGGER.info("addActivities()");
        User user = (User) session.getAttribute("logged_user");
        workflow.setId(id);
        String[] split = ids.split(",");
        for (String idAdd : split) {
            Activity activity = activityService.find(Integer.valueOf(idAdd));
            workflow.addActivity(activity);
        }
        Collections.sort(workflow.getActivities());
        model.addAttribute("workflowForm", workflow);
        populateDefaultModel(model, user.getAgent().getResearcher());

        return "experiments/workflows/workflows-form";
    }

    @RequestMapping(value = "/experiments/workflows/{id}/removeActivity", method = RequestMethod.POST)
    public String removeActivity(@ModelAttribute("workflowForm") Workflow workflow, @PathVariable("id") int id, @RequestParam("id") int idRemove, Model model, HttpSession session) {

        LOGGER.info("removeActivity()");
        User user = (User) session.getAttribute("logged_user");
        workflow.setId(id);
        Activity activity = activityService.find(idRemove);
        workflow.removeActivity(activity);
        model.addAttribute("workflowForm", workflow);
        populateDefaultModel(model, user.getAgent().getResearcher());

        return "experiments/workflows/workflows-form";
    }

    @RequestMapping(value = "/experiments/workflows/{id}/update", method = RequestMethod.GET)
    public String showUpdateWorkflowForm(@PathVariable("id") int id, Model model, HttpSession session) {

        LOGGER.log(Level.INFO, "showUpdateWorkflowForm() : {0}", id);
        User user = (User) session.getAttribute("logged_user");
        Workflow workflow = workflowService.find(id);
        for (WorkflowActivity activity : workflow.getActivities()) {
            activity.setActivity(activityService.find(activity.getId().getActivityId()));
        }
        Collections.sort(workflow.getActivities());
        model.addAttribute("workflowForm", workflow);
        model.addAttribute("workflowActivities", workflow.getActivities());
        populateDefaultModel(model, user.getAgent().getResearcher());
        return "experiments/workflows/workflows-form";
    }

    @RequestMapping(value = "/experiments/workflows", method = RequestMethod.POST)
    public String saveOrUpdateWorkflow(@ModelAttribute("workflowForm") @Validated Workflow workflow,
            BindingResult result, Model model, final RedirectAttributes redirectAttributes, HttpSession session) {

        LOGGER.log(Level.INFO, "saveOrUpdateWorkflow() : {0}", workflow);
        User user = (User) session.getAttribute("logged_user");
        if (result.hasErrors()) {
            populateDefaultModel(model, user.getAgent().getResearcher());
            return "experiments/workflows/workflows-form";
        } else {
            redirectAttributes.addFlashAttribute("css", "success");
            if (workflow.isNew()) {
                redirectAttributes.addFlashAttribute("msg", "Workflow added successfully!");
            } else {
                redirectAttributes.addFlashAttribute("msg", "Workflow updated successfully!");
            }

            try {
                workflow = workflowService.saveOrUpdate(workflow);
                for (Experiment experiment : workflow.getExperiments()) {
                    experiment = experimentService.find(experiment.getId());
                    experiment.getWorkflows().add(workflow);
                    experimentService.saveOrUpdate(experiment);
                }

                return "redirect:/experiments/workflows/" + workflow.getId();

            } catch (Exception ex) {
                LOGGER.log(Level.SEVERE, null, ex);
                populateDefaultModel(model, user.getAgent().getResearcher());
                return "experiments/workflows/workflows-form";
            }
        }
    }

    @RequestMapping(value = "/experiments/workflows/{id}/delete", method = RequestMethod.POST)
    public String deleteWorkflow(@PathVariable("id") int id, final RedirectAttributes redirectAttributes) {

        LOGGER.log(Level.INFO, "deleteWorkflow() : {0}", id);

        Workflow workflow = workflowService.find(id);
//        workflow.removeAllActivities();
        try {
            workflow = workflowService.saveOrUpdate(workflow);
            workflowService.delete(workflow);
            redirectAttributes.addFlashAttribute("css", "success");
            redirectAttributes.addFlashAttribute("msg", "Workflow has been deleted!");
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, null, ex);
            redirectAttributes.addFlashAttribute("css", "danger");
            redirectAttributes.addFlashAttribute("msg", ex.getMessage());
        }

        return "redirect:/experiments/workflows";
    }

    @RequestMapping(value = "/experiments/workflows/{id}", method = RequestMethod.GET)
    public String showWorkflow(@PathVariable("id") int id, Model model, HttpSession session) {

        LOGGER.log(Level.INFO, "showWorkflow() id: {0}", id);

        Workflow workflow = workflowService.find(id);

        if (workflow == null) {
            model.addAttribute("css", "danger");
            model.addAttribute("msg", "Workflow not found");
        } else {
            for (WorkflowActivity activity : workflow.getActivities()) {
                activity.setActivity(activityService.find(activity.getId().getActivityId()));
            }
            Collections.sort(workflow.getActivities());
        }
        model.addAttribute("workflowTreeJSON", getWorkflowTree(id));
        model.addAttribute("workflow", workflow);
        return "experiments/workflows/show";
    }

    private void populateDefaultModel(Model model, Researcher r) {

        model.addAttribute("wfmsList", wfmsService.findAll());
        model.addAttribute("experimentsList", experimentService.findAll());
        ArrayList<Activity> myActivitiesList = new ArrayList<>();
        ArrayList<Activity> otherActivitiesList = new ArrayList<>();
        for (Activity a : activityService.findAll()) {
            if (a.getAuthor().getId() == r.getId()) {
                myActivitiesList.add(a);
            } else {
                otherActivitiesList.add(a);
            }

        }
        model.addAttribute("myActivitiesList", myActivitiesList);
        model.addAttribute("otherActivitiesList", otherActivitiesList);
    }

    private JSONObject getWorkflowTree(int id) {
        JSONObject tree = new JSONObject();
        JSONObject nodes = new JSONObject();
        JSONObject links = new JSONObject();
        List<WorkflowActivity> workflowActivities = workflowService.find(id).getActivities();
        for (WorkflowActivity wa : workflowActivities) {
            wa.setActivity(activityService.find(wa.getId().getActivityId()));
            wa.setWorkflow(workflowService.find(wa.getId().getWorkflowId()));
        }
        Collections.sort(workflowActivities);

        int position = 0;
        int phases = 0;

        for (int i = 0; i < workflowActivities.size(); i++) {
            WorkflowActivity workflowActivity = workflowActivities.get(i);

            if (i == 0 || workflowActivities.get(i - 1).getOrderExec() != workflowActivity.getOrderExec()) {
                position = 1;
                phases++;
            } else {
                position++;
            }

            JSONObject activityJson = new JSONObject();
            Activity activity = workflowActivity.getActivity();
            activityJson.put("name", activity.getName());
            activityJson.put("orderExec", workflowActivity.getOrderExec());
            activityJson.put("description", activity.getDescription().replaceAll(":", " ").replaceAll(",", " "));
            activityJson.put("author", activity.getAuthor().getDisplayName());

            if (activity.getAuthor().getId() != workflowActivity.getWorkflow().getAuthor().getId()) {
                for (WorkflowActivity wa : activity.getWorkflows()) {
                    wa.setWorkflow(workflowService.find(wa.getId().getWorkflowId()));
                    if (wa.getWorkflow().getAuthor().getId() == activity.getAuthor().getId()) {
                        activityJson.put("reusedFrom", wa.getWorkflow().getName());
                    }
                }
            } else {
                String workflows = "";
                for (WorkflowActivity wa : activity.getWorkflows()) {
                    wa.setWorkflow(workflowService.find(wa.getId().getWorkflowId()));
                    if (wa.getWorkflow().getAuthor().getId() != activity.getAuthor().getId()) {
                        workflows += wa.getWorkflow().getName() + ", ";
                        activityJson.put("reusedBy", workflows);
                    }
                }
            }

            int nextSiblings = 0;
            for (int j = i + 1; j < workflowActivities.size(); j++) {
                WorkflowActivity workflowActivity2 = workflowActivities.get(j);
                if (workflowActivity2.getOrderExec() == workflowActivity.getOrderExec() + 1) {
                    JSONObject linkJson = new JSONObject();
                    linkJson.put("activity1", workflowActivity.getActivity().getId());
                    linkJson.put("activity2", workflowActivity2.getActivity().getId());
                    links.put(workflowActivity.getActivity().getId() + "_" + workflowActivity2.getActivity().getId(), linkJson);
                } else if (workflowActivity2.getOrderExec() == workflowActivity.getOrderExec()) {
                    nextSiblings++;
                }
            }

            activityJson.put("siblings", position + nextSiblings);
            activityJson.put("position", position);
            nodes.put(String.valueOf(workflowActivity.getActivity().getId()), activityJson);

        }

        tree.put("nodes", nodes);
        tree.put("links", links);
        tree.put("phases", phases);
        return tree;
    }
}
