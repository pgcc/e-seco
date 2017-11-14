package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.validator.ExperimentWorkflowFormValidator;
import br.ufjf.pgcc.eseco.domain.model.experiment.Experiment;
import br.ufjf.pgcc.eseco.domain.model.experiment.Wfms;
import br.ufjf.pgcc.eseco.domain.model.experiment.Workflow;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.experiment.ExperimentService;
import br.ufjf.pgcc.eseco.domain.service.experiment.WfmsService;
import br.ufjf.pgcc.eseco.domain.service.experiment.WorkflowService;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
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

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(workflowFormValidator);
    }

    @Autowired
    public void setWorkflowService(ExperimentService experimentService, WorkflowService workflowService,
            WfmsService wfmsService) {
        this.experimentService = experimentService;
        this.workflowService = workflowService;
        this.wfmsService = wfmsService;
    }

    @RequestMapping(value = "/experiments/workflows", method = RequestMethod.GET)
    public String showAllWorkflows(Model model) {

        LOGGER.info("showAllWorkflows()");
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
        Wfms wfms = new Wfms();
        workflow.setWfms(wfms);

        model.addAttribute("workflowForm", workflow);
        populateDefaultModel(model);

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

        model.addAttribute("workflowForm", workflow);
        populateDefaultModel(model);

        return "experiments/workflows/workflows-form";
    }

    @RequestMapping(value = "/experiments/workflows/{id}/update", method = RequestMethod.GET)
    public String showUpdateWorkflowForm(@PathVariable("id") int id, Model model) {

        LOGGER.log(Level.INFO, "showUpdateWorkflowForm() : {0}", id);

        Workflow workflow = workflowService.find(id);
        model.addAttribute("workflowForm", workflow);

        populateDefaultModel(model);
        return "experiments/workflows/workflows-form";
    }

    @RequestMapping(value = "/experiments/workflows", method = RequestMethod.POST)
    public String saveOrUpdateWorkflow(@ModelAttribute("workflowForm") @Validated Workflow workflow,
            BindingResult result, Model model, final RedirectAttributes redirectAttributes, HttpSession session) {

        LOGGER.log(Level.INFO, "saveOrUpdateWorkflow() : {0}", workflow);

        if (result.hasErrors()) {
            populateDefaultModel(model);
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
                for (Experiment experiment : workflow.getExperiments()){
                    experiment = experimentService.find(experiment.getId());
                    experiment.getWorkflows().add(workflow);
                    experimentService.saveOrUpdate(experiment);
                }
               
                return "redirect:/experiments/workflows/" + workflow.getId();

            } catch (Exception ex) {
                LOGGER.log(Level.SEVERE, null, ex);
                populateDefaultModel(model);
                return "experiments/workflows/workflows-form";
            }
        }
    }

    @RequestMapping(value = "/experiments/workflows/{id}/delete", method = RequestMethod.POST)
    public String deleteWorkflow(@PathVariable("id") int id, final RedirectAttributes redirectAttributes) {

        LOGGER.log(Level.INFO, "deleteWorkflow() : {0}", id);

        Workflow workflow = workflowService.find(id);
        try {
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
        }

        model.addAttribute("workflow", workflow);
        return "experiments/workflows/show";
    }

    private void populateDefaultModel(Model model) {

        model.addAttribute("wfmsList", wfmsService.findAll());
        model.addAttribute("experimentsList", experimentService.findAll());
    }

}
