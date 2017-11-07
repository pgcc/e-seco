package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.validator.ExperimentWorkflowExecutionFormValidator;
import br.ufjf.pgcc.eseco.domain.model.experiment.WorkflowExecution;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.experiment.WorkflowExecutionService;
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
@SessionAttributes({"workflowExecutionForm"})
public class ExperimentWorkflowExecutionsController {

    private static final Logger LOGGER = Logger.getLogger(ExperimentWorkflowExecutionsController.class.getName());

    @Autowired
    ExperimentWorkflowExecutionFormValidator workflowExecutionFormValidator;

    private WorkflowExecutionService workflowExecutionService;

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(workflowExecutionFormValidator);
    }

    @Autowired
    public void setWorkflowExecutionService(WorkflowExecutionService workflowExecutionService) {
        this.workflowExecutionService = workflowExecutionService;
    }

    @RequestMapping(value = "/experiments/workflowExecutions", method = RequestMethod.GET)
    public String showAllWorkflowExecutions(Model model) {

        LOGGER.info("showAllWorkflowExecutions()");
        model.addAttribute("workflowExecutions", workflowExecutionService.findAll());

        return "experiments/workflowExecutions/list";
    }

    @RequestMapping(value = "/experiments/workflowExecutions/add", method = RequestMethod.GET)
    public String showAddWorkflowExecutionForm(Model model, HttpSession session) {

        LOGGER.info("showAddWorkflowExecutionForm()");

        User user = (User) session.getAttribute("logged_user");

        WorkflowExecution workflowExecution = new WorkflowExecution();
        // set default value
        workflowExecution.setAuthor(user.getAgent().getResearcher());
        model.addAttribute("workflowExecutionForm", workflowExecution);
        populateDefaultModel(model);
        
        return "experiments/workflowExecutions/workflow-executions-form";
    }

    @RequestMapping(value = "/experiments/workflowExecutions/{id}/update", method = RequestMethod.GET)
    public String showUpdateWorkflowExecutionForm(@PathVariable("id") int id, Model model) {

        LOGGER.log(Level.INFO, "showUpdateWorkflowExecutionForm() : {0}", id);

        WorkflowExecution workflowExecution = workflowExecutionService.find(id);
        model.addAttribute("workflowExecutionForm", workflowExecution);

        populateDefaultModel(model);
        return "experiments/workflowExecutions/workflow-executions-form";
    }

    @RequestMapping(value = "/experiments/workflowExecutions", method = RequestMethod.POST)
    public String saveOrUpdateWorkflowExecution(@ModelAttribute("workflowExecutionForm") @Validated WorkflowExecution workflowExecution,
            BindingResult result, Model model, final RedirectAttributes redirectAttributes, HttpSession session) {

        LOGGER.log(Level.INFO, "saveOrUpdateWorkflowExecution() : {0}", workflowExecution);

        if (result.hasErrors()) {
            populateDefaultModel(model);
            return "experiments/workflowExecutions/workflow-executions-form";
        } else {
            redirectAttributes.addFlashAttribute("css", "success");
            if (workflowExecution.isNew()) {
                redirectAttributes.addFlashAttribute("msg", "Workflow Execution added successfully!");
            } else {
                redirectAttributes.addFlashAttribute("msg", "Workflow Execution updated successfully!");
            }

            try {
                workflowExecution = workflowExecutionService.saveOrUpdate(workflowExecution);
                return "redirect:/experiments/workflowExecutions/" + workflowExecution.getId();
            } catch (Exception ex) {
                LOGGER.log(Level.SEVERE, null, ex);
                populateDefaultModel(model);
                return "experiments/workflowExecutions/workflow-executions-form";
            }
        }
    }

    @RequestMapping(value = "/experiments/workflowExecutions/{id}/delete", method = RequestMethod.POST)
    public String deleteWorkflowExecution(@PathVariable("id") int id, final RedirectAttributes redirectAttributes) {

        LOGGER.log(Level.INFO, "deleteWorkflowExecution() : {0}", id);

        WorkflowExecution workflowExecution = workflowExecutionService.find(id);
        try {
            workflowExecutionService.delete(workflowExecution);
            redirectAttributes.addFlashAttribute("css", "success");
            redirectAttributes.addFlashAttribute("msg", "Workflow Execution has been deleted!");
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, null, ex);
            redirectAttributes.addFlashAttribute("css", "danger");
            redirectAttributes.addFlashAttribute("msg", ex.getMessage());
        }

        return "redirect:/experiments/workflowExecutions";
    }

    @RequestMapping(value = "/experiments/workflowExecutions/{id}", method = RequestMethod.GET)
    public String showWorkflowExecution(@PathVariable("id") int id, Model model, HttpSession session) {

        LOGGER.log(Level.INFO, "showWorkflowExecution() id: {0}", id);

        WorkflowExecution workflowExecution = workflowExecutionService.find(id);
        if (workflowExecution == null) {
            model.addAttribute("css", "danger");
            model.addAttribute("msg", "WorkflowExecution not found");
        }

        model.addAttribute("workflowExecution", workflowExecution);
        return "experiments/workflowExecutions/show";

    }

    /**
     * Populates the lists of objects required to listbox items
     *
     * @param model
     */
    private void populateDefaultModel(Model model) {
       
    }

}
