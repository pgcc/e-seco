package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.validator.ResearchGroupFormValidator;
import br.ufjf.pgcc.eseco.domain.model.core.ResearchGroup;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.core.ResearchGroupService;
import br.ufjf.pgcc.eseco.domain.service.core.ResearcherService;
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
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@SessionAttributes({"researchGroupForm"})
public class ResearchGroupsController {

    private static final Logger LOGGER = Logger.getLogger(ResearchGroupsController.class.getName());

    @Autowired
    ResearchGroupFormValidator researchGroupFormValidator;

    private ResearchGroupService researchGroupService;
    private ResearcherService researcherService;

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(researchGroupFormValidator);
    }

    @Autowired
    public void setResearchGroupService(ResearchGroupService researchGroupService, 
            ResearcherService researcherService) {
        this.researchGroupService = researchGroupService;
        this.researcherService = researcherService;
    }

    @RequestMapping(value = "/researchGroups", method = RequestMethod.GET)
    public String showAllResearchGroups(Model model) {

        LOGGER.info("showAllResearchGroups()");
        model.addAttribute("researchGroups", researchGroupService.findAll());

        return "researchGroups/list";
    }

    @RequestMapping(value = "/researchGroups/add", method = RequestMethod.GET)
    public String showAddResearchGroupForm(Model model, HttpSession session) {

        LOGGER.info("showAddResearchGroupForm()");

        User user = (User) session.getAttribute("logged_user");

        ResearchGroup researchGroup = new ResearchGroup();
        model.addAttribute("researchGroupForm", researchGroup);
        populateDefaultModel(model);

        return "researchGroups/research-groups-form";
    }

    @RequestMapping(value = "/researchGroups/{id}/update", method = RequestMethod.GET)
    public String showUpdateResearchGroupForm(@PathVariable("id") int id, Model model) {

        LOGGER.log(Level.INFO, "showUpdateResearchGroupForm() : {0}", id);

        ResearchGroup researchGroup = researchGroupService.find(id);
        model.addAttribute("researchGroupForm", researchGroup);

        populateDefaultModel(model);
        return "researchGroups/research-groups-form";
    }

    @RequestMapping(value = "/researchGroups", method = RequestMethod.POST)
    public String saveOrUpdateResearchGroup(@ModelAttribute("researchGroupForm") @Validated ResearchGroup researchGroup,
            BindingResult result, Model model, final RedirectAttributes redirectAttributes, HttpSession session) {

        LOGGER.log(Level.INFO, "saveOrUpdateResearchGroup() : {0}", researchGroup);

        if (result.hasErrors()) {
            populateDefaultModel(model);
            return "researchGroups/research-groups-form";
        } else {
            redirectAttributes.addFlashAttribute("css", "success");
            if (researchGroup.isNew()) {
                redirectAttributes.addFlashAttribute("msg", "ResearchGroup added successfully!");
            } else {
                redirectAttributes.addFlashAttribute("msg", "ResearchGroup updated successfully!");
            }

            try {
                researchGroup = researchGroupService.saveOrUpdate(researchGroup);
                return "redirect:/researchGroups/" + researchGroup.getId();
            } catch (Exception ex) {
                LOGGER.log(Level.SEVERE, null, ex);
                populateDefaultModel(model);
                return "researchGroups/research-groups-form";
            }
        }
    }

    @RequestMapping(value = "/researchGroups/{id}/delete", method = RequestMethod.POST)
    public String deleteResearchGroup(@PathVariable("id") int id, final RedirectAttributes redirectAttributes) {

        LOGGER.log(Level.INFO, "deleteResearchGroup() : {0}", id);

        ResearchGroup researchGroup = researchGroupService.find(id);
        try {
            researchGroupService.delete(researchGroup);
            redirectAttributes.addFlashAttribute("css", "success");
            redirectAttributes.addFlashAttribute("msg", "ResearchGroup has been deleted!");
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, null, ex);
            redirectAttributes.addFlashAttribute("css", "danger");
            redirectAttributes.addFlashAttribute("msg", ex.getMessage());
        }

        return "redirect:/researchGroups";
    }

    @RequestMapping(value = "/researchGroups/{id}", method = RequestMethod.GET)
    public String showResearchGroup(@PathVariable("id") int id, Model model, HttpSession session) {

        LOGGER.log(Level.INFO, "showResearchGroup() id: {0}", id);

        ResearchGroup researchGroup = researchGroupService.find(id);
        if (researchGroup == null) {
            model.addAttribute("css", "danger");
            model.addAttribute("msg", "ResearchGroup not found");
        }

        model.addAttribute("researchGroup", researchGroup);
        return "researchGroups/show";

    }

    /**
     * Populates the lists of objects required to listbox items
     *
     * @param model
     */
    private void populateDefaultModel(Model model) {
        List<Researcher> researches = researcherService.findAll();
        model.addAttribute("researchesList", researches);
    }

}
