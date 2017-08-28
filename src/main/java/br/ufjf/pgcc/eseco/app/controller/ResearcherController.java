package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.service.MendeleyService;
import br.ufjf.pgcc.eseco.domain.model.core.Agent;
import br.ufjf.pgcc.eseco.domain.service.core.AgentService;
import br.ufjf.pgcc.eseco.domain.service.core.ResearcherService;
import br.ufjf.pgcc.eseco.common.controller.CommonController;
import br.ufjf.pgcc.eseco.domain.model.core.Institution;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.core.InstitutionService;

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

@Controller
public class ResearcherController extends CommonController {

    private ResearcherService researcherService;
    private InstitutionService institutionService;
    private AgentService agentService;
    private Researcher researcher;

    @Autowired
    public ResearcherController(ResearcherService researcherService, InstitutionService institutionService, AgentService agentService) {
        this.researcherService = researcherService;
        this.institutionService = institutionService;
        this.agentService = agentService;
    }

    @RequestMapping(value = "/researchers", method = RequestMethod.GET)
    public String showAddResearcherForm(Model model) {

        researcher = new Researcher();

        model.addAttribute("researcherForm", researcher);

        return "researchers/researcherform";
    }

    @RequestMapping(value = "/researchers/{id}", method = RequestMethod.GET)
    public String showUpdateResearcherForm(@PathVariable("id") int id, Model model) {

        researcher = researcherService.find(id);

        model.addAttribute("researcherForm", researcher);

        return "researchers/researcherform";

    }

    @RequestMapping(value = "/researchers", method = RequestMethod.POST)
    public String saveOrUpdateResearcher(@ModelAttribute("researcherForm") Researcher researcher, HttpSession session,
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
                // Save Institutions of researcher
                for (Institution institution : researcher.getInstitutions()) {
                    institutionService.saveOrUpdate(institution);
                }

                // Get agent
                Agent agent = ((User) session.getAttribute("logged_user")).getAgent();

                // Save or Update Researcher
                researcher.setAgent(agent);
                researcher = researcherService.saveOrUpdate(researcher);

                // Update the Agent Researcher ID
                agent.setResearcher(researcher);
                agentService.updateAgent(agent);

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
    public String mendeleySearch(@ModelAttribute("researcherForm") @Validated Researcher r, Model model) {

        MendeleyService mendeleyService = new MendeleyService();
        List<Researcher> lista = mendeleyService.searchByEmail(r.getAgent().getUser().getEmail());
        if (lista.size() == 1) {
            Researcher res = lista.get(0);
            researcher.setAcademicStatus(res.getAcademicStatus());
            researcher.setDisplayName(res.getDisplayName());
            researcher.setMendeleyId(res.getMendeleyId());
            researcher.setTitle(res.getTitle());
            researcher.setInstitutions(res.getInstitutions());
        }
        model.addAttribute("researcherForm", researcher);

        return "researchers/researcherform";
    }
}
