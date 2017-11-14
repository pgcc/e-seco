package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.validator.InstitutionFormValidator;
import br.ufjf.pgcc.eseco.domain.model.core.Institution;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.core.CityService;
import br.ufjf.pgcc.eseco.domain.service.core.InstitutionService;
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
@SessionAttributes({"institutionForm"})
public class InstitutionsController {

    private static final Logger LOGGER = Logger.getLogger(InstitutionsController.class.getName());

    @Autowired
    InstitutionFormValidator institutionFormValidator;

    private InstitutionService institutionService;
    private CityService cityService;

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(institutionFormValidator);
    }

    @Autowired
    public void setInstitutionService(InstitutionService institutionService, CityService cityService) {
        this.institutionService = institutionService;
        this.cityService = cityService;
    }

    @RequestMapping(value = "/institutions", method = RequestMethod.GET)
    public String showAllInstitutions(Model model) {

        LOGGER.info("showAllInstitutions()");
        model.addAttribute("institutions", institutionService.findAll());

        return "institutions/list";
    }

    @RequestMapping(value = "/institutions/add", method = RequestMethod.GET)
    public String showAddInstitutionForm(Model model, HttpSession session) {

        LOGGER.info("showAddInstitutionForm()");

        User user = (User) session.getAttribute("logged_user");

        Institution institution = new Institution();
        model.addAttribute("institutionForm", institution);
        populateDefaultModel(model);

        return "institutions/institutions-form";
    }

    @RequestMapping(value = "/institutions/{id}/update", method = RequestMethod.GET)
    public String showUpdateInstitutionForm(@PathVariable("id") int id, Model model) {

        LOGGER.log(Level.INFO, "showUpdateInstitutionForm() : {0}", id);

        Institution institution = institutionService.find(id);
        model.addAttribute("institutionForm", institution);

        populateDefaultModel(model);
        return "institutions/institutions-form";
    }

    @RequestMapping(value = "/institutions", method = RequestMethod.POST)
    public String saveOrUpdateInstitution(@ModelAttribute("institutionForm") @Validated Institution institution,
            BindingResult result, Model model, final RedirectAttributes redirectAttributes, HttpSession session) {

        LOGGER.log(Level.INFO, "saveOrUpdateInstitution() : {0}", institution);

        if (result.hasErrors()) {
            populateDefaultModel(model);
            return "institutions/institutions-form";
        } else {
            redirectAttributes.addFlashAttribute("css", "success");
            if (institution.isNew()) {
                redirectAttributes.addFlashAttribute("msg", "Institution added successfully!");
            } else {
                redirectAttributes.addFlashAttribute("msg", "Institution updated successfully!");
            }

            try {
                institution = institutionService.saveOrUpdate(institution);
                return "redirect:/institutions/" + institution.getId();
            } catch (Exception ex) {
                LOGGER.log(Level.SEVERE, null, ex);
                populateDefaultModel(model);
                return "institutions/institutions-form";
            }
        }
    }

    @RequestMapping(value = "/institutions/{id}/delete", method = RequestMethod.POST)
    public String deleteInstitution(@PathVariable("id") int id, final RedirectAttributes redirectAttributes) {

        LOGGER.log(Level.INFO, "deleteInstitution() : {0}", id);

        Institution institution = institutionService.find(id);
        try {
            institutionService.delete(institution);
            redirectAttributes.addFlashAttribute("css", "success");
            redirectAttributes.addFlashAttribute("msg", "Institution has been deleted!");
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, null, ex);
            redirectAttributes.addFlashAttribute("css", "danger");
            redirectAttributes.addFlashAttribute("msg", ex.getMessage());
        }

        return "redirect:/institutions";
    }

    @RequestMapping(value = "/institutions/{id}", method = RequestMethod.GET)
    public String showInstitution(@PathVariable("id") int id, Model model, HttpSession session) {

        LOGGER.log(Level.INFO, "showInstitution() id: {0}", id);

        Institution institution = institutionService.find(id);
        if (institution == null) {
            model.addAttribute("css", "danger");
            model.addAttribute("msg", "Institution not found");
        }

        model.addAttribute("institution", institution);
        return "institutions/show";

    }

    /**
     * Populates the lists of objects required to listbox items
     *
     * @param model
     */
    private void populateDefaultModel(Model model) {
        model.addAttribute("citiesList", cityService.findAll());
    }

}
