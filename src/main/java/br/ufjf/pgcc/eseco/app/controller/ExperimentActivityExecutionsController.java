package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.validator.ExperimentActivityExecutionFormValidator;
import br.ufjf.pgcc.eseco.domain.model.experiment.ActivityExecution;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.experiment.ActivityExecutionService;
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
@SessionAttributes({"activityExecutionForm"})
public class ExperimentActivityExecutionsController {

    private static final Logger LOGGER = Logger.getLogger(ExperimentActivityExecutionsController.class.getName());

    @Autowired
    ExperimentActivityExecutionFormValidator activityExecutionFormValidator;

    private ActivityExecutionService activityExecutionService;

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(activityExecutionFormValidator);
    }

    @Autowired
    public void setActivityExecutionService(ActivityExecutionService activityExecutionService) {
        this.activityExecutionService = activityExecutionService;
    }

    @RequestMapping(value = "/experiments/activityExecutions", method = RequestMethod.GET)
    public String showAllActivityExecutions(Model model) {

        LOGGER.info("showAllActivityExecutions()");
        model.addAttribute("activityExecutions", activityExecutionService.findAll());

        return "experiments/activityExecutions/list";
    }

    @RequestMapping(value = "/experiments/activityExecutions/add", method = RequestMethod.GET)
    public String showAddActivityExecutionForm(Model model, HttpSession session) {

        LOGGER.info("showAddActivityExecutionForm()");

        User user = (User) session.getAttribute("logged_user");

        ActivityExecution activityExecution = new ActivityExecution();
        // set default value
        activityExecution.setAuthor(user.getAgent().getResearcher());
        model.addAttribute("activityExecutionForm", activityExecution);
        populateDefaultModel(model);
        
        return "experiments/activityExecutions/activity-executions-form";
    }

    @RequestMapping(value = "/experiments/activityExecutions/{id}/update", method = RequestMethod.GET)
    public String showUpdateActivityExecutionForm(@PathVariable("id") int id, Model model) {

        LOGGER.log(Level.INFO, "showUpdateActivityExecutionForm() : {0}", id);

        ActivityExecution activityExecution = activityExecutionService.find(id);
        model.addAttribute("activityExecutionForm", activityExecution);

        populateDefaultModel(model);
        return "experiments/activityExecutions/activity-executions-form";
    }

    @RequestMapping(value = "/experiments/activityExecutions", method = RequestMethod.POST)
    public String saveOrUpdateActivityExecution(@ModelAttribute("activityExecutionForm") @Validated ActivityExecution activityExecution,
            BindingResult result, Model model, final RedirectAttributes redirectAttributes, HttpSession session) {

        LOGGER.log(Level.INFO, "saveOrUpdateActivityExecution() : {0}", activityExecution);

        if (result.hasErrors()) {
            populateDefaultModel(model);
            return "experiments/activityExecutions/activity-executions-form";
        } else {
            redirectAttributes.addFlashAttribute("css", "success");
            if (activityExecution.isNew()) {
                redirectAttributes.addFlashAttribute("msg", "Activity Execution added successfully!");
            } else {
                redirectAttributes.addFlashAttribute("msg", "Activity Execution updated successfully!");
            }

            try {
                activityExecution = activityExecutionService.saveOrUpdate(activityExecution);
                return "redirect:/experiments/activityExecutions/" + activityExecution.getId();
            } catch (Exception ex) {
                LOGGER.log(Level.SEVERE, null, ex);
                populateDefaultModel(model);
                return "experiments/activityExecutions/activity-executions-form";
            }
        }
    }

    @RequestMapping(value = "/experiments/activityExecutions/{id}/delete", method = RequestMethod.POST)
    public String deleteActivityExecution(@PathVariable("id") int id, final RedirectAttributes redirectAttributes) {

        LOGGER.log(Level.INFO, "deleteActivityExecution() : {0}", id);

        ActivityExecution activityExecution = activityExecutionService.find(id);
        try {
            activityExecutionService.delete(activityExecution);
            redirectAttributes.addFlashAttribute("css", "success");
            redirectAttributes.addFlashAttribute("msg", "Activity Execution has been deleted!");
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, null, ex);
            redirectAttributes.addFlashAttribute("css", "danger");
            redirectAttributes.addFlashAttribute("msg", ex.getMessage());
        }

        return "redirect:/experiments/activityExecutions";
    }

    @RequestMapping(value = "/experiments/activityExecutions/{id}", method = RequestMethod.GET)
    public String showActivityExecution(@PathVariable("id") int id, Model model, HttpSession session) {

        LOGGER.log(Level.INFO, "showActivityExecution() id: {0}", id);

        ActivityExecution activityExecution = activityExecutionService.find(id);
        if (activityExecution == null) {
            model.addAttribute("css", "danger");
            model.addAttribute("msg", "ActivityExecution not found");
        }

        model.addAttribute("activityExecution", activityExecution);
        return "experiments/activityExecutions/show";

    }

    /**
     * Populates the lists of objects required to listbox items
     *
     * @param model
     */
    private void populateDefaultModel(Model model) {
       
    }

}