package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.validator.ExperimentFormValidator;
import br.ufjf.pgcc.eseco.app.validator.ExperimentWorkflowFormValidator;
import br.ufjf.pgcc.eseco.domain.model.core.Discipline;
import br.ufjf.pgcc.eseco.domain.model.core.Institution;
import br.ufjf.pgcc.eseco.domain.model.core.ResearchGroup;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import br.ufjf.pgcc.eseco.domain.model.experiment.Experiment;
import br.ufjf.pgcc.eseco.domain.model.experiment.ExperimentPhase;
import br.ufjf.pgcc.eseco.domain.model.experiment.ExperimentStatus;
import br.ufjf.pgcc.eseco.domain.model.experiment.Wfms;
import br.ufjf.pgcc.eseco.domain.model.experiment.Workflow;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.core.DisciplineService;
import br.ufjf.pgcc.eseco.domain.service.core.InstitutionService;
import br.ufjf.pgcc.eseco.domain.service.core.ResearchGroupService;
import br.ufjf.pgcc.eseco.domain.service.core.ResearcherService;
import br.ufjf.pgcc.eseco.domain.service.experiment.ExperimentService;
import br.ufjf.pgcc.eseco.domain.service.experiment.WorkflowService;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@SessionAttributes({"experimentWorkflowForm"})
public class ExperimentWorkflowsController {

    private static final Logger LOGGER = Logger.getLogger(ExperimentWorkflowsController.class.getName());

    @Autowired
    ExperimentWorkflowFormValidator experimentWorkflowFormValidator;

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(experimentWorkflowFormValidator);
    }

    private ExperimentService experimentService;
    private ResearcherService researcherService;
    private WorkflowService workflowService;

    @Autowired
    public void setExperimentService(ExperimentService experimentService, ResearcherService researcherService,
            WorkflowService workflowService) {
        this.experimentService = experimentService;
        this.researcherService = researcherService;
        this.workflowService = workflowService;
    }

    @RequestMapping(value = "/experiments/workflows", method = RequestMethod.POST)
    public String saveOrUpdateExperimentWorkflow(@ModelAttribute("experimentWorkflowForm") @Validated Workflow workflow,
            BindingResult result, Model model, final RedirectAttributes redirectAttributes) {

        LOGGER.log(Level.INFO, "saveOrUpdateExperimentWorkflow() : {0}", workflow);

        if (result.hasErrors()) {
            populateDefaultModel(model);
            return "experiments/experiments-workflows-form";
        } else {
            redirectAttributes.addFlashAttribute("css", "success");
            if (workflow.isNew()) {
                redirectAttributes.addFlashAttribute("msg", "Experiment Workflow added successfully!");
            } else {
                redirectAttributes.addFlashAttribute("msg", "Experiment Workflow updated successfully!");
            }

            try {
                workflow = workflowService.saveOrUpdate(workflow);
                return "redirect:/experiments/" + workflow.getExperiments().get(0).getId();
            } catch (Exception ex) {
                Logger.getLogger(ExperimentWorkflowsController.class.getName()).log(Level.SEVERE, null, ex);
                populateDefaultModel(model);                
                return "experiments/experiments-workflows-form";
            }

        }

    }

    @RequestMapping(value = "/experiments/{experimentId}/workflows/add", method = RequestMethod.GET)
    public String showAddExperimentWorkflowForm(Model model, @PathVariable("experimentId") int experimentId,
            HttpSession session) {

        LOGGER.info("showAddExperimentWorkflowForm()");

        User user = (User) session.getAttribute("logged_user");
        Experiment experiment = experimentService.find(experimentId);
        Workflow workflow = new Workflow();

        // set default value
        workflow.setAuthor(user.getAgent().getResearcher());
        workflow.setDateCreated(new Date());
        workflow.setVersion("1.0.0");
        Wfms wfms = new Wfms();
        wfms.setId(1);
        workflow.setWfms(wfms);
        ArrayList<Experiment> experiments = new ArrayList<>();
        experiments.add(experiment);
        workflow.setExperiments(experiments);
        model.addAttribute("experimentWorkflowForm", workflow);
        session.setAttribute("current_experiment_id", experimentId);

        populateDefaultModel(model);

        return "experiments/experiments-workflows-form";

    }

    @RequestMapping(value = "/experiments/workflows/{id}/update", method = RequestMethod.GET)
    public String showUpdateExperimentWorkflowForm(@PathVariable("id") int id, Model model) {

        LOGGER.log(Level.INFO, "showUpdateExperimentWorkflowForm() : {0}", id);

        Workflow workflow = workflowService.find(id);
        model.addAttribute("experimentWorkflowForm", workflow);

        populateDefaultModel(model);

        return "experiments/experiments-workflows-form";

    }

    @RequestMapping(value = "/experiments/workflows/{id}/delete", method = RequestMethod.POST)
    public String deleteExperimentWorkflow(@PathVariable("id") int id, final RedirectAttributes redirectAttributes) {

        LOGGER.log(Level.INFO, "deleteExperimentWorkflow() : {0}", id);

        Workflow workflow = workflowService.find(id);
        try {
            workflowService.delete(workflow);
        } catch (Exception ex) {
            Logger.getLogger(ExperimentWorkflowsController.class.getName()).log(Level.SEVERE, null, ex);
        }

        redirectAttributes.addFlashAttribute("css", "success");
        redirectAttributes.addFlashAttribute("msg", "Experiment Workflow is deleted!");

        return "redirect:/experiments";

    }

    @RequestMapping(value = "/experiments/workflows/{id}", method = RequestMethod.GET)
    public String showExperiment(@PathVariable("id") int id, Model model, HttpSession session) {

        LOGGER.log(Level.INFO, "showExperiment() id: {0}", id);

        Workflow workflow = workflowService.find(id);
        if (workflow == null) {
            model.addAttribute("css", "danger");
            model.addAttribute("msg", "Experiment Workflow not found");
        }

        model.addAttribute("workflow", workflow);

        return "experiments/workflows/show";

    }

    private void populateDefaultModel(Model model) {

        List<Researcher> researches = researcherService.findAll();
        model.addAttribute("researchesList", researches);

        List<Workflow> workflows = workflowService.findAll();
        model.addAttribute("workflowsList", workflows);

    }

    @ExceptionHandler(EmptyResultDataAccessException.class)
    public ModelAndView handleEmptyData(HttpServletRequest req, Exception ex) {

        LOGGER.info("handleEmptyData()");
        LOGGER.log(Level.INFO, "Request: {0}, error {1}", new Object[]{req.getRequestURL(), ex});

        ModelAndView model = new ModelAndView();
        model.setViewName("experiment/workflow/show");
        model.addObject("msg", "experiment workflow not found");

        return model;

    }

}
