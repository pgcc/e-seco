package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.service.MendeleyService;
import br.ufjf.pgcc.eseco.app.validator.ExperimentWorkflowExecutionFormValidator;
import br.ufjf.pgcc.eseco.app.validator.ResearcherFormValidator;
import br.ufjf.pgcc.eseco.domain.model.core.Agent;
import br.ufjf.pgcc.eseco.domain.service.core.AgentService;
import br.ufjf.pgcc.eseco.domain.service.core.ResearcherService;
import br.ufjf.pgcc.eseco.common.controller.CommonController;
import br.ufjf.pgcc.eseco.domain.model.core.Discipline;
import br.ufjf.pgcc.eseco.domain.model.core.Institution;
import br.ufjf.pgcc.eseco.domain.model.core.Interest;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.core.DisciplineService;
import br.ufjf.pgcc.eseco.domain.service.core.InstitutionService;
import br.ufjf.pgcc.eseco.domain.service.core.InterestService;
import br.ufjf.pgcc.eseco.domain.service.experiment.WorkflowExecutionService;
import java.io.IOException;

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
@SessionAttributes({"researcherForm"})
public class ResearchersController extends CommonController {

    private static final Logger LOGGER = Logger.getLogger(ExperimentsController.class.getName());

    private final ResearcherService researcherService;
    private final InstitutionService institutionService;
    private final AgentService agentService;
    private final DisciplineService disciplineService;
    private final InterestService interestService;
    private final MendeleyService mendeleyService;

    @Autowired
    ResearcherFormValidator researcherFormValidator;

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(researcherFormValidator);
    }

    @Autowired
    public ResearchersController(ResearcherService researcherService, InstitutionService institutionService,
            AgentService agentService, DisciplineService disciplineService, InterestService interestService,
            MendeleyService mendeleyService) {
        this.researcherService = researcherService;
        this.institutionService = institutionService;
        this.agentService = agentService;
        this.disciplineService = disciplineService;
        this.interestService = interestService;
        this.mendeleyService = mendeleyService;
    }

    @RequestMapping(value = "/researchers/add", method = RequestMethod.GET)
    public String showAddResearcherForm(Model model, HttpSession session) {

        LOGGER.info("showAddResearcherForm()");

        User user = (User) session.getAttribute("logged_user");
        if (user.getAgent() != null && user.getAgent().getResearcher() != null) {
            return "redirect:/researchers/" + user.getAgent().getResearcher().getId();
        } else {
            Researcher researcher = new Researcher();
            researcher.setAgent(user.getAgent());
            model.addAttribute("researcherForm", researcher);
            populateDefaultModel(model);
            return "researchers/researcher-form";
        }
    }

    @RequestMapping(value = "/researchers/{id}", method = RequestMethod.GET)
    public String showResearcher(@PathVariable("id") int id, Model model, HttpSession session) {

        LOGGER.log(Level.INFO, "showResearcher() : {0}", id);

        Researcher researcher = researcherService.find(id);

        if (researcher == null) {
            model.addAttribute("css", "danger");
            model.addAttribute("msg", "Researcher not found");

            User user = (User) session.getAttribute("logged_user");
            researcher = new Researcher();
            researcher.setAgent(user.getAgent());
            model.addAttribute("researcherForm", researcher);
            return "researchers/researcher-form";
        }
        model.addAttribute("researcher", researcher);
        return "researchers/show";

    }

    @RequestMapping(value = "/researchers/{id}/update", method = RequestMethod.GET)
    public String showUpdateResearcherForm(@PathVariable("id") int id, Model model) {

        LOGGER.log(Level.INFO, "showUpdateResearcherForm() : {0}", id);

        Researcher researcher = researcherService.find(id);
        model.addAttribute("researcherForm", researcher);
        populateDefaultModel(model);

        return "researchers/researcher-form";

    }

    @RequestMapping(value = "/researchers", method = RequestMethod.POST)
    public String saveOrUpdateResearcher(@ModelAttribute("researcherForm") @Validated Researcher researcher,
            BindingResult result, Model model, final RedirectAttributes redirectAttributes, HttpSession session) {

        LOGGER.log(Level.INFO, "saveOrUpdateResearcher() : {0}", researcher);

        if (!result.hasErrors()) {

            redirectAttributes.addFlashAttribute("css", "success");
            if (researcher.isNew()) {
                redirectAttributes.addFlashAttribute("msg", "Researcher added successfully!");
            } else {
                redirectAttributes.addFlashAttribute("msg", "Researcher updated successfully!");
            }
            try {
                researcher = researcherService.saveOrUpdate(researcher);
                Agent agent = researcher.getAgent();
                if (agent == null) {
                    agent = ((User) session.getAttribute("logged_user")).getAgent();
                    agent.setResearcher(researcher);
                    researcher.setAgent(agent);
                    researcher = researcherService.saveOrUpdate(researcher);
                }
                return "redirect:/researchers/" + researcher.getId();
            } catch (Exception ex) {
                LOGGER.log(Level.SEVERE, null, ex);
                model.addAttribute("css", "danger");
                model.addAttribute("msg", ex);
            }
        }
        Agent agent = ((User) session.getAttribute("logged_user")).getAgent();
        researcher.setAgent(agent);
        model.addAttribute("researcherForm", researcher);
        populateDefaultModel(model);
        return "researchers/researcher-form";
    }

    @RequestMapping(value = "/researchers/mendeleySearch", method = RequestMethod.GET)
    public String mendeleySearch(@ModelAttribute("researcherForm") Researcher researcher, Model model) {

        User user = researcher.getAgent().getUser();
        LOGGER.log(Level.INFO, "mendeleySearch() : {0}", user.getEmail());

        try {
            List<Researcher> lista = mendeleyService.searchByEmail(user.getEmail());
            if (lista.size() == 1) {
                Researcher res = lista.get(0);
                res = saveNewObjects(res);
                researcher.setAcademicStatus(res.getAcademicStatus());
                researcher.setDisplayName(res.getDisplayName());
                researcher.setMendeleyId(res.getMendeleyId());
                researcher.setTitle(res.getTitle());
                researcher.setPhoto(res.getPhoto());
                researcher.setMendeleyId(res.getMendeleyId());
                researcher.setInstitutions(res.getInstitutions());
                researcher.setDisciplines(res.getDisciplines());
                researcher.setResearchInterests(res.getResearchInterests());
            } else {
                model.addAttribute("css", "warning");
                model.addAttribute("msg", "Researcher not found!");
            }
        } catch (IOException ex) {
            LOGGER.log(Level.SEVERE, null, ex);
            model.addAttribute("css", "danger");
            model.addAttribute("msg", ex);
        }

        model.addAttribute("researcherForm", researcher);
        populateDefaultModel(model);
        return "researchers/researcher-form";
    }

    /**
     * Saves the new objects related to Researcher
     *
     * @param r
     * @throws Exception
     */
    private Researcher saveNewObjects(Researcher r) {
        try {
            for (Institution i : r.getInstitutions()) {
                Institution findByName = institutionService.findByName(i.getName());
                if (findByName == null) {
                    i = institutionService.saveOrUpdate(i);
                } else {
                    i.setId(findByName.getId());
                }
            }
            for (Discipline d : r.getDisciplines()) {
                Discipline findByName = disciplineService.findByName(d.getName());
                if (findByName == null) {
                    d = disciplineService.saveOrUpdate(d);
                } else {
                    d.setId(findByName.getId());
                }
            }
            for (Interest i : r.getResearchInterests()) {
                Interest findByName = interestService.findByName(i.getName());
                if (findByName == null) {
                    i = interestService.saveOrUpdate(i);
                } else {
                    i.setId(findByName.getId());
                }
            }
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, null, ex);
        }
        return r;
    }

    private void populateDefaultModel(Model model) {
        model.addAttribute("institutionsList", institutionService.findAll());
        model.addAttribute("interestsList", interestService.findAll());
        model.addAttribute("disciplinesList", disciplineService.findAll());
    }
}
