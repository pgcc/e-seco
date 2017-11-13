package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.validator.DisciplineFormValidator;
import br.ufjf.pgcc.eseco.domain.model.core.Discipline;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.core.DisciplineService;
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
@SessionAttributes({"disciplineForm"})
public class DisciplinesController {
    
    private static final Logger LOGGER = Logger.getLogger(DisciplinesController.class.getName());
    
    @Autowired
    DisciplineFormValidator disciplineFormValidator;
    
    private DisciplineService disciplineService;
    
    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(disciplineFormValidator);
    }
    
    @Autowired
    public void setDisciplineService(DisciplineService disciplineService) {
        this.disciplineService = disciplineService;
    }
    
    @RequestMapping(value = "/disciplines", method = RequestMethod.GET)
    public String showAllDisciplines(Model model) {
        
        LOGGER.info("showAllDisciplines()");
        model.addAttribute("disciplines", disciplineService.findAll());
        
        return "disciplines/list";
    }
    
    @RequestMapping(value = "/disciplines/add", method = RequestMethod.GET)
    public String showAddDisciplineForm(Model model, HttpSession session) {
        
        LOGGER.info("showAddDisciplineForm()");
        
        User user = (User) session.getAttribute("logged_user");
        
        Discipline discipline = new Discipline();
        model.addAttribute("disciplineForm", discipline);
        populateDefaultModel(model);
        
        return "disciplines/disciplines-form";
    }
    
    @RequestMapping(value = "/disciplines/{id}/update", method = RequestMethod.GET)
    public String showUpdateDisciplineForm(@PathVariable("id") int id, Model model) {
        
        LOGGER.log(Level.INFO, "showUpdateDisciplineForm() : {0}", id);
        
        Discipline discipline = disciplineService.find(id);
        model.addAttribute("disciplineForm", discipline);
        
        populateDefaultModel(model);
        return "disciplines/disciplines-form";
    }
    
    @RequestMapping(value = "/disciplines", method = RequestMethod.POST)
    public String saveOrUpdateDiscipline(@ModelAttribute("disciplineForm") @Validated Discipline discipline,
            BindingResult result, Model model, final RedirectAttributes redirectAttributes, HttpSession session) {
        
        LOGGER.log(Level.INFO, "saveOrUpdateDiscipline() : {0}", discipline);
        
        if (result.hasErrors()) {
            populateDefaultModel(model);
            return "disciplines/disciplines-form";
        } else {
            redirectAttributes.addFlashAttribute("css", "success");
            if (discipline.isNew()) {
                redirectAttributes.addFlashAttribute("msg", "Discipline added successfully!");
            } else {
                redirectAttributes.addFlashAttribute("msg", "Discipline updated successfully!");
            }
            
            try {
                if (discipline.getParent().getId() == 0) {
                    discipline.setParent(null);
                }
                discipline = disciplineService.saveOrUpdate(discipline);
                return "redirect:/disciplines/" + discipline.getId();
            } catch (Exception ex) {
                LOGGER.log(Level.SEVERE, null, ex);
                populateDefaultModel(model);
                return "disciplines/disciplines-form";
            }
        }
    }
    
    @RequestMapping(value = "/disciplines/{id}/delete", method = RequestMethod.POST)
    public String deleteDiscipline(@PathVariable("id") int id, final RedirectAttributes redirectAttributes) {
        
        LOGGER.log(Level.INFO, "deleteDiscipline() : {0}", id);
        
        Discipline discipline = disciplineService.find(id);
        try {
            disciplineService.delete(discipline);
            redirectAttributes.addFlashAttribute("css", "success");
            redirectAttributes.addFlashAttribute("msg", "Discipline has been deleted!");
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, null, ex);
            redirectAttributes.addFlashAttribute("css", "danger");
            redirectAttributes.addFlashAttribute("msg", ex.getMessage());
        }
        
        return "redirect:/disciplines";
    }
    
    @RequestMapping(value = "/disciplines/{id}", method = RequestMethod.GET)
    public String showDiscipline(@PathVariable("id") int id, Model model, HttpSession session) {
        
        LOGGER.log(Level.INFO, "showDiscipline() id: {0}", id);
        
        Discipline discipline = disciplineService.find(id);
        if (discipline == null) {
            model.addAttribute("css", "danger");
            model.addAttribute("msg", "Discipline not found");
        }
        
        model.addAttribute("discipline", discipline);
        return "disciplines/show";
        
    }

    /**
     * Populates the lists of objects required to listbox items
     *
     * @param model
     */
    private void populateDefaultModel(Model model) {
        List<Discipline> disciplinesList = disciplineService.findAll();
        disciplinesList.add(new Discipline());
        model.addAttribute("disciplinesList", disciplinesList);
    }
    
}
