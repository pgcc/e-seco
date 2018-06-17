package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.validator.ExperimentActivityFormValidator;
import br.ufjf.pgcc.eseco.domain.model.experiment.Activity;
import br.ufjf.pgcc.eseco.domain.model.experiment.Detail;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowService;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.resource.WorkflowServiceService;
import br.ufjf.pgcc.eseco.domain.service.experiment.ActivityService;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@SessionAttributes({"activityForm"})
public class ExperimentActivitiesController {

    private static final Logger LOGGER = Logger.getLogger(ExperimentActivitiesController.class.getName());

    @Autowired
    ExperimentActivityFormValidator activityFormValidator;

    private ActivityService activityService;
    private WorkflowServiceService workflowServiceService;

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(activityFormValidator);
    }

    @Autowired
    public void setActivityService(ActivityService activityService, WorkflowServiceService workflowServiceService) {
        this.activityService = activityService;
        this.workflowServiceService = workflowServiceService;
    }

    @RequestMapping(value = "/experiments/activities", method = RequestMethod.GET)
    public String showAllActivities(Model model, HttpSession session) {

        LOGGER.info("showAllActivities()");
        ArrayList<Activity> myactivities = new ArrayList<>();
        ArrayList<Activity> activities = new ArrayList<>();

        User user = (User) session.getAttribute("logged_user");
        for (Activity a : activityService.findAll()) {
            if (a.getAuthor().getId() == user.getAgent().getResearcher().getId()) {
                myactivities.add(a);
            } else {
                activities.add(a);
            }
        }

        model.addAttribute("myactivities", myactivities);
        model.addAttribute("activities", activities);

        return "experiments/activities/list";
    }

    @RequestMapping(value = "/experiments/activities/add", method = RequestMethod.GET)
    public String showAddActivityForm(Model model, HttpSession session) {

        LOGGER.info("showAddActivityForm()");

        User user = (User) session.getAttribute("logged_user");

        Activity activity = new Activity();
        // set default value
        activity.setAuthor(user.getAgent().getResearcher());
        activity.setDateCreated(new Date());
        List<Detail> details = new ArrayList<>();
        details.add(new Detail());
        activity.setDetails(details);

        model.addAttribute("activityForm", activity);
        return "experiments/activities/activities-form";
    }

    @RequestMapping(value = "/experiments/activities/addDetail", method = RequestMethod.POST)
    public String addDetail(@ModelAttribute("activityForm") Activity activity, Model model, HttpSession session) {

        LOGGER.info("addDetail()");

        List<Detail> details = activity.getDetails();
        details.add(new Detail());
        activity.setDetails(details);
        model.addAttribute("activityForm", activity);
        populateDefaultModel(model);

        return "experiments/activities/activities-form";
    }

    @RequestMapping(value = "/experiments/activities/removeDetail", method = RequestMethod.POST)
    public String removeDetail(@ModelAttribute("activityForm") Activity activity, @RequestParam("index") int index, Model model, HttpSession session) {

        LOGGER.info("removeDetail()");

        if (activity.getDetails().size() > 1) {
            activity.getDetails().remove(index);
        } else {
            activity.getDetails().set(index, new Detail());
        }
        model.addAttribute("activityForm", activity);
        populateDefaultModel(model);

        return "experiments/activities/activities-form";
    }

    @RequestMapping(value = "/experiments/activities/{id}/update", method = RequestMethod.GET)
    public String showUpdateActivityForm(@PathVariable("id") int id, Model model) {

        LOGGER.log(Level.INFO, "showUpdateActivityForm() : {0}", id);

        Activity activity = activityService.find(id);
        if (activity.getDetails() == null || activity.getDetails().isEmpty()) {
            List<Detail> details = new ArrayList<>();
            details.add(new Detail());
            activity.setDetails(details);
        }
        model.addAttribute("activityForm", activity);

        populateDefaultModel(model);
        return "experiments/activities/activities-form";
    }

    @RequestMapping(value = "/experiments/activities", method = RequestMethod.POST)
    public String saveOrUpdateActivity(@ModelAttribute("activityForm") @Validated Activity activity,
            BindingResult result, Model model, final RedirectAttributes redirectAttributes, HttpSession session) {

        LOGGER.log(Level.INFO, "saveOrUpdateActivity() : {0}", activity);

        if (result.hasErrors()) {
            populateDefaultModel(model);
            return "experiments/activities/activities-form";
        } else {
            redirectAttributes.addFlashAttribute("css", "success");
            if (activity.isNew()) {
                redirectAttributes.addFlashAttribute("msg", "Activity added successfully!");
            } else {
                redirectAttributes.addFlashAttribute("msg", "Activity updated successfully!");
            }

            try {
                ArrayList<Detail> details = new ArrayList<>();
                for (Detail d : activity.getDetails()) {
                    if (d.getName() != null && !d.getName().isEmpty()) {
                        details.add(d);
                    }
                }
                activity.setDetails(details);

                activity = activityService.saveOrUpdate(activity);
                return "redirect:/experiments/activities/" + activity.getId();
            } catch (Exception ex) {
                LOGGER.log(Level.SEVERE, null, ex);
                populateDefaultModel(model);
                return "experiments/activities/activities-form";
            }
        }
    }

    @RequestMapping(value = "/experiments/activities/{id}/delete", method = RequestMethod.POST)
    public String deleteActivity(@PathVariable("id") int id, final RedirectAttributes redirectAttributes) {

        LOGGER.log(Level.INFO, "deleteActivity() : {0}", id);

        Activity activity = activityService.find(id);
        try {
            activityService.delete(activity);
            redirectAttributes.addFlashAttribute("css", "success");
            redirectAttributes.addFlashAttribute("msg", "Activity has been deleted!");
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, null, ex);
            redirectAttributes.addFlashAttribute("css", "danger");
            redirectAttributes.addFlashAttribute("msg", ex.getMessage());
        }

        return "redirect:/experiments/activities";
    }

    @RequestMapping(value = "/experiments/activities/{id}", method = RequestMethod.GET)
    public String showActivity(@PathVariable("id") int id, Model model, HttpSession session) {

        LOGGER.log(Level.INFO, "showActivity() id: {0}", id);

        Activity activity = activityService.find(id);
        if (activity == null) {
            model.addAttribute("css", "danger");
            model.addAttribute("msg", "Activity not found");
        }

        model.addAttribute("activity", activity);
        return "experiments/activities/show";

    }

    /**
     * Populates the lists of objects required to listbox items
     *
     * @param model
     */
    private void populateDefaultModel(Model model) {

        List<WorkflowService> servicesList = workflowServiceService.findAll();
        model.addAttribute("servicesList", servicesList);
    }

}
