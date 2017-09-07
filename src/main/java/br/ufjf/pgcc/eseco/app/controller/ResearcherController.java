package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.service.MendeleyService;
import br.ufjf.pgcc.eseco.domain.model.core.Agent;
import br.ufjf.pgcc.eseco.domain.service.core.AgentService;
import br.ufjf.pgcc.eseco.domain.service.core.ResearcherService;
import br.ufjf.pgcc.eseco.common.controller.CommonController;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@SessionAttributes({"researcher"})
public class ResearcherController extends CommonController {

    private final ResearcherService researcherService;
    private final InstitutionService institutionService;
    private final AgentService agentService;
    private final MendeleyService mendeleyService;

    @Autowired
    public ResearcherController(ResearcherService researcherService, InstitutionService institutionService,
            AgentService agentService, MendeleyService mendeleyService) {
        this.researcherService = researcherService;
        this.institutionService = institutionService;
        this.agentService = agentService;
        this.mendeleyService = mendeleyService;
    }

    @RequestMapping(value = "/researchers", method = RequestMethod.GET)
    public String showAddResearcherForm(Model model, HttpSession session) {
        User user = (User) session.getAttribute("logged_user");
        if (user.getAgent() != null && user.getAgent().getResearcher() != null) {
            return "redirect:/researchers/" + user.getAgent().getResearcher().getId();
        } else {
            Researcher researcher = new Researcher();
            model.addAttribute("user", user);
            model.addAttribute("researcher", researcher);
            return "researchers/researcherform";
        }
    }

    @RequestMapping(value = "/researchers/{id}", method = RequestMethod.GET)
    public String showUpdateResearcherForm(@PathVariable("id") int id, Model model) {
        Researcher researcher = researcherService.find(id);
        model.addAttribute("user", researcher.getAgent().getUser());
        model.addAttribute("researcher", researcher);
        return "researchers/researcherform";

    }

    @RequestMapping(value = "/researchers", method = RequestMethod.POST)
    public String saveOrUpdateResearcher(@ModelAttribute("researcher") Researcher researcher, HttpSession session,
            Model model) {

        try {

            Agent agent = researcher.getAgent();
            if (agent == null) {
                agent = ((User) session.getAttribute("logged_user")).getAgent();
                agent.setResearcher(researcher);
                researcher.setAgent(agent);
                //researcher = researcherService.saveOrUpdate(researcher);
            }
            researcher = researcherService.saveOrUpdate(researcher);

        } catch (Exception ex) {
            ex.printStackTrace();
            Logger.getLogger(ResearcherController.class.getName()).log(Level.SEVERE, null, ex);
        }

        return "redirect:/researchers/" + researcher.getId();

    }

    @RequestMapping(value = "/researchers/mendeleySearch", method = RequestMethod.GET)
    public String mendeleySearch(@ModelAttribute("user") User user, @ModelAttribute("researcher") Researcher researcher, Model model) {

        List<Researcher> lista = mendeleyService.searchByEmail(user.getEmail());
        if (lista.size() == 1) {
            Researcher res = lista.get(0);

            researcher.setAcademicStatus(res.getAcademicStatus());
            researcher.setDisplayName(res.getDisplayName());
            researcher.setMendeleyId(res.getMendeleyId());
            researcher.setTitle(res.getTitle());
            researcher.setMendeleyId(res.getMendeleyId());
            researcher.setInstitutions(res.getInstitutions());
        }
        model.addAttribute("institutions", researcher.getInstitutions());
        model.addAttribute("user", user);
        model.addAttribute("researcher", researcher);

        return "researchers/researcherform";
    }
}
