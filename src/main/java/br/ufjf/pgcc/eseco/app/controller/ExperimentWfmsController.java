package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.validator.ExperimentWfmsFormValidator;
import br.ufjf.pgcc.eseco.domain.model.experiment.Wfms;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.experiment.WfmsService;
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
@SessionAttributes({"wfmsForm"})
public class ExperimentWfmsController {

    private static final Logger LOGGER = Logger.getLogger(ExperimentWfmsController.class.getName());

    @Autowired
    ExperimentWfmsFormValidator wfmsFormValidator;

    private WfmsService wfmsService;

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(wfmsFormValidator);
    }

    @Autowired
    public void setWfmsService(WfmsService wfmsService) {
        this.wfmsService = wfmsService;
    }

    @RequestMapping(value = "/experiments/wfms", method = RequestMethod.GET)
    public String showAllWfms(Model model) {

        LOGGER.info("showAllWfms()");
        model.addAttribute("wfmss", wfmsService.findAll());

        return "experiments/wfms/list";
    }

    @RequestMapping(value = "/experiments/wfms/add", method = RequestMethod.GET)
    public String showAddWfmsForm(Model model, HttpSession session) {

        LOGGER.info("showAddWfmsForm()");

        User user = (User) session.getAttribute("logged_user");

        Wfms wfms = new Wfms();
        model.addAttribute("wfmsForm", wfms);
        populateDefaultModel(model);
        
        return "experiments/wfms/wfms-form";
    }

    @RequestMapping(value = "/experiments/wfms/{id}/update", method = RequestMethod.GET)
    public String showUpdateWfmsForm(@PathVariable("id") int id, Model model) {

        LOGGER.log(Level.INFO, "showUpdateWfmsForm() : {0}", id);

        Wfms wfms = wfmsService.find(id);
        model.addAttribute("wfmsForm", wfms);

        populateDefaultModel(model);
        return "experiments/wfms/wfms-form";
    }

    @RequestMapping(value = "/experiments/wfms", method = RequestMethod.POST)
    public String saveOrUpdateWfms(@ModelAttribute("wfmsForm") @Validated Wfms wfms,
            BindingResult result, Model model, final RedirectAttributes redirectAttributes, HttpSession session) {

        LOGGER.log(Level.INFO, "saveOrUpdateWfms() : {0}", wfms);

        if (result.hasErrors()) {
            populateDefaultModel(model);
            return "experiments/wfms/wfms-form";
        } else {
            redirectAttributes.addFlashAttribute("css", "success");
            if (wfms.isNew()) {
                redirectAttributes.addFlashAttribute("msg", "Wfms added successfully!");
            } else {
                redirectAttributes.addFlashAttribute("msg", "Wfms updated successfully!");
            }

            try {
                wfms = wfmsService.saveOrUpdate(wfms);
                return "redirect:/experiments/wfms/" + wfms.getId();
            } catch (Exception ex) {
                LOGGER.log(Level.SEVERE, null, ex);
                populateDefaultModel(model);
                return "experiments/wfms/wfms-form";
            }
        }
    }

    @RequestMapping(value = "/experiments/wfms/{id}/delete", method = RequestMethod.POST)
    public String deleteWfms(@PathVariable("id") int id, final RedirectAttributes redirectAttributes) {

        LOGGER.log(Level.INFO, "deleteWfms() : {0}", id);

        Wfms wfms = wfmsService.find(id);
        try {
            wfmsService.delete(wfms);
            redirectAttributes.addFlashAttribute("css", "success");
            redirectAttributes.addFlashAttribute("msg", "Wfms has been deleted!");
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, null, ex);
            redirectAttributes.addFlashAttribute("css", "danger");
            redirectAttributes.addFlashAttribute("msg", ex.getMessage());
        }

        return "redirect:/experiments/wfms";
    }

    @RequestMapping(value = "/experiments/wfms/{id}", method = RequestMethod.GET)
    public String showWfms(@PathVariable("id") int id, Model model, HttpSession session) {

        LOGGER.log(Level.INFO, "showWfms() id: {0}", id);

        Wfms wfms = wfmsService.find(id);
        if (wfms == null) {
            model.addAttribute("css", "danger");
            model.addAttribute("msg", "Wfms not found");
        }

        model.addAttribute("wfms", wfms);
        return "experiments/wfms/show";

    }

    /**
     * Populates the lists of objects required to listbox items
     *
     * @param model
     */
    private void populateDefaultModel(Model model) {
       
    }

}
