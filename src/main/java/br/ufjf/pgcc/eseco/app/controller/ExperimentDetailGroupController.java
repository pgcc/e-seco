package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.validator.DetailGroupFormValidator;
import br.ufjf.pgcc.eseco.domain.model.experiment.DetailGroup;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.experiment.DetailGroupService;
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
@SessionAttributes({"detailGroupForm"})
public class ExperimentDetailGroupController {

    private static final Logger LOGGER = Logger.getLogger(ExperimentDetailGroupController.class.getName());

    @Autowired
    DetailGroupFormValidator detailGroupFormValidator;

    private DetailGroupService detailGroupService;

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(detailGroupFormValidator);
    }

    @Autowired
    public void setDetailGroupService(DetailGroupService detailGroupService) {
        this.detailGroupService = detailGroupService;
    }

    @RequestMapping(value = "/experiments/detailGroup", method = RequestMethod.GET)
    public String showAllDetailGroup(Model model) {

        LOGGER.info("showAllDetailGroup()");
        model.addAttribute("detailGroups", detailGroupService.findAll());

        return "experiments/detailGroup/list";
    }

    @RequestMapping(value = "/experiments/detailGroup/add", method = RequestMethod.GET)
    public String showAddDetailGroupForm(Model model, HttpSession session) {

        LOGGER.info("showAddDetailGroupForm()");

        User user = (User) session.getAttribute("logged_user");

        DetailGroup detailGroup = new DetailGroup();
        model.addAttribute("detailGroupForm", detailGroup);
        populateDefaultModel(model);
        
        return "experiments/detailGroup/detail-group-form";
    }

    @RequestMapping(value = "/experiments/detailGroup/{id}/update", method = RequestMethod.GET)
    public String showUpdateDetailGroupForm(@PathVariable("id") int id, Model model) {

        LOGGER.log(Level.INFO, "showUpdateDetailGroupForm() : {0}", id);

        DetailGroup detailGroup = detailGroupService.find(id);
        model.addAttribute("detailGroupForm", detailGroup);

        populateDefaultModel(model);
        return "experiments/detailGroup/detail-group-form";
    }

    @RequestMapping(value = "/experiments/detailGroup", method = RequestMethod.POST)
    public String saveOrUpdateDetailGroup(@ModelAttribute("detailGroupForm") @Validated DetailGroup detailGroup,
            BindingResult result, Model model, final RedirectAttributes redirectAttributes, HttpSession session) {

        LOGGER.log(Level.INFO, "saveOrUpdateDetailGroup() : {0}", detailGroup);

        if (result.hasErrors()) {
            populateDefaultModel(model);
            return "experiments/detailGroup/detail-group-form";
        } else {
            redirectAttributes.addFlashAttribute("css", "success");
            if (detailGroup.isNew()) {
                redirectAttributes.addFlashAttribute("msg", "DetailGroup added successfully!");
            } else {
                redirectAttributes.addFlashAttribute("msg", "DetailGroup updated successfully!");
            }

            try {
                detailGroup = detailGroupService.saveOrUpdate(detailGroup);
                return "redirect:/experiments/detailGroup/" + detailGroup.getId();
            } catch (Exception ex) {
                LOGGER.log(Level.SEVERE, null, ex);
                populateDefaultModel(model);
                return "experiments/detailGroup/detail-group-form";
            }
        }
    }

    @RequestMapping(value = "/experiments/detailGroup/{id}/delete", method = RequestMethod.POST)
    public String deleteDetailGroup(@PathVariable("id") int id, final RedirectAttributes redirectAttributes) {

        LOGGER.log(Level.INFO, "deleteDetailGroup() : {0}", id);

        DetailGroup detailGroup = detailGroupService.find(id);
        try {
            detailGroupService.delete(detailGroup);
            redirectAttributes.addFlashAttribute("css", "success");
            redirectAttributes.addFlashAttribute("msg", "DetailGroup has been deleted!");
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, null, ex);
            redirectAttributes.addFlashAttribute("css", "danger");
            redirectAttributes.addFlashAttribute("msg", ex.getMessage());
        }

        return "redirect:/experiments/detailGroup";
    }

    @RequestMapping(value = "/experiments/detailGroup/{id}", method = RequestMethod.GET)
    public String showDetailGroup(@PathVariable("id") int id, Model model, HttpSession session) {

        LOGGER.log(Level.INFO, "showDetailGroup() id: {0}", id);

        DetailGroup detailGroup = detailGroupService.find(id);
        if (detailGroup == null) {
            model.addAttribute("css", "danger");
            model.addAttribute("msg", "DetailGroup not found");
        }

        model.addAttribute("detailGroup", detailGroup);
        return "experiments/detailGroup/show";

    }

    /**
     * Populates the lists of objects required to listbox items
     *
     * @param model
     */
    private void populateDefaultModel(Model model) {
       
    }

}
