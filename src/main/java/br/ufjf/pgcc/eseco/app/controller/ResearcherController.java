/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.DatabaseInitiator;
import br.ufjf.pgcc.eseco.app.service.MendeleyService;
import br.ufjf.pgcc.eseco.domain.service.core.ResearcherService;
import br.ufjf.pgcc.eseco.common.controller.CommonController;
import br.ufjf.pgcc.eseco.domain.model.core.Institution;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.core.InstitutionService;
import br.ufjf.pgcc.eseco.domain.service.uac.UserService;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 *
 * @author Lenita
 */
@Controller
public class ResearcherController extends CommonController {

    @Autowired
    private ResearcherService researcherService;

    @Autowired
    private InstitutionService institutionService;

    @Autowired
    private UserService userService;

    private Researcher researcher;
    private User user;
    private Institution institution;

    @Autowired
    public ResearcherController(ResearcherService researcherService) {
        this.researcherService = researcherService;
    }

    @RequestMapping(value = "/researchers", method = RequestMethod.GET)
    public String showAddResearcherForm(Model model, HttpSession session) {

        new DatabaseInitiator().contextInitialized(null);
        user = (User) session.getAttribute("logged_user");
        institution = new Institution();
        researcher = new Researcher();
        researcher.setInstitution(institution);
        researcher.setUser(user);
        model.addAttribute("researcherForm", researcher);

        return "researchers/researcherform";
    }

    @RequestMapping(value = "/researchers/{id}", method = RequestMethod.GET)
    public String showUpdateResearcherForm(@PathVariable("id") int id, Model model, HttpSession session) {

        researcher = researcherService.find(id);
//        institution = institutionService.find(researcher.getInstitution().getId());
//        user = userService.find(researcher.getUser().getId());
        user = (User) session.getAttribute("logged_user");
        institution = new Institution();
        researcher.setInstitution(institution);
        researcher.setUser(user);
        model.addAttribute("researcherForm", researcher);

        return "researchers/researcherform";

    }

    @RequestMapping(value = "/researchers", method = RequestMethod.POST)
    public String saveOrUpdateResearcher(@ModelAttribute("researcherForm") Researcher researcher,
            BindingResult result, Model model, final RedirectAttributes redirectAttributes) {

        if (result.hasErrors()) {
            return "researchers/researcherform";
        } else {

            // Add message to flash scope
            redirectAttributes.addFlashAttribute("css", "success");
            if (researcher.getId() == 0) {
                redirectAttributes.addFlashAttribute("msg", "Researcher added successfully!");
            } else {
                redirectAttributes.addFlashAttribute("msg", "Researcher updated successfully!");
            }
            try {
                user = userService.saveOrUpdate(user);
                institution = institutionService.saveOrUpdate(researcher.getInstitution());
                researcher.setUser(user);
                researcher.setInstitution(institution);
                researcher = researcherService.saveOrUpdate(researcher);

            } catch (Exception ex) {
                ex.printStackTrace();
                Logger.getLogger(ResearcherController.class.getName()).log(Level.SEVERE, null, ex);
            }

            // POST/REDIRECT/GET
            return "redirect:/researchers/" + researcher.getId();

            // POST/FORWARD/GET
            // return "user/list";
        }
    }

    @RequestMapping(value = "/researchers/mendeleySearch", method = RequestMethod.POST)
    public String mendeleySearch(@ModelAttribute("researcherForm") @Validated Researcher r, HttpSession session, Model model) {

        MendeleyService mendeleyService = new MendeleyService();
        List<Researcher> lista = mendeleyService.searchByEmail(r.getUser().getEmail());
        if (lista.size() == 1) {
            Researcher res = lista.get(0);
            researcher.setAcademicStatus(res.getAcademicStatus());
            researcher.setDisplayName(res.getDisplayName());
            researcher.setMendeleyId(res.getMendeleyId());
            researcher.setTitle(res.getTitle());
            researcher.setInstitution(res.getInstitution());
        }
        model.addAttribute("researcherForm", researcher);
        return "researchers/researcherform";
    }
}
