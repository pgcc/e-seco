package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.service.MendeleyService;
import br.ufjf.pgcc.eseco.app.validator.ResearcherFormValidator;
import br.ufjf.pgcc.eseco.domain.model.core.*;
import br.ufjf.pgcc.eseco.domain.service.core.*;
import br.ufjf.pgcc.eseco.common.controller.CommonController;
import br.ufjf.pgcc.eseco.domain.model.experiment.Experiment;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.experiment.ExperimentService;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
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
    private final ResearcherKeywordService researcherKeywordService;
    private final ExperimentService experimentService;

    @Autowired
    ResearcherFormValidator researcherFormValidator;

    @InitBinder("researcherForm")
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(researcherFormValidator);
    }

    @Autowired
    public ResearchersController(ResearcherService researcherService, InstitutionService institutionService,
            AgentService agentService, DisciplineService disciplineService, InterestService interestService,
            MendeleyService mendeleyService, ResearcherKeywordService researcherKeywordService,
            ExperimentService experimentService) {
        this.researcherService = researcherService;
        this.institutionService = institutionService;
        this.agentService = agentService;
        this.disciplineService = disciplineService;
        this.interestService = interestService;
        this.mendeleyService = mendeleyService;
        this.researcherKeywordService = researcherKeywordService;
        this.experimentService = experimentService;
    }

    @RequestMapping(value = "/researchers", method = RequestMethod.GET)
    public String showAllResearchers(Model model) {

        LOGGER.info("showAllResearchers()");
        List<Researcher> allResearchers = researcherService.findAll();

        model.addAttribute("researchers", allResearchers);
        model.addAttribute("researchRelationsGraphJSON", getResearchRelationsGraph());
        model.addAttribute("researchExperimentsChartJSON", getResearchExperimentsChart());
        return "researchers/list";
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

        // Transform context info into JSON String
        List<ResearcherKeyword> researcherKeywordList = new ArrayList<>();

        for (ResearcherKeyword rk : researcher.getResearchKeywords()) {
            ResearcherKeyword newRk = new ResearcherKeyword();
            newRk.setName(rk.getName());
            researcherKeywordList.add(newRk);
        }

        Gson gson = new GsonBuilder().create();
        String researcherKeywordsJSON = gson.toJson(researcherKeywordList);

        model.addAttribute("researcher", researcher);
        model.addAttribute("researcherKeywordsJSON", researcherKeywordsJSON);

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

                // Add Keywords List
                List<String> keyList = new ArrayList<>();
                List<ResearcherKeyword> keywordsList = new ArrayList<>();
                if (researcher.getMendeleyId() != null) {
                    for (ResearcherKeyword rk : mendeleyService.searchKeywordsByProfileId(researcher.getMendeleyId())) {
                        String key = rk.getName().toLowerCase() + "-" + rk.getYear();
                        if (!keyList.contains(key)) {
                            keyList.add(key);

                            rk.setName(rk.getName().toLowerCase());
                            rk.setResearcher(researcher);
                            keywordsList.add(rk);
                        }
                    }
                }

                // Delete previous keywords
                /*
                for (ResearcherKeyword rk : researcher.getResearchKeywords()) {
                    researcherKeywordService.delete(rk);
                }
                 */
                // Add new keywords
                researcher.setResearchKeywords(keywordsList);
                for (ResearcherKeyword rk : researcher.getResearchKeywords()) {
                    rk.setResearcher(researcher);
                    researcherKeywordService.saveOrUpdate(rk);
                }

                return "redirect:/researchers/" + researcher.getId();

            } catch (Exception ex) {
                LOGGER.log(Level.SEVERE, null, ex);
                model.addAttribute("css", "danger");
                model.addAttribute("msg", ex);
            }
        }
//        Agent agent = ((User) session.getAttribute("logged_user")).getAgent();
//        researcher.setAgent(agent);
//        model.addAttribute("researcherForm", researcher);
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
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, null, ex);
            model.addAttribute("css", "danger");
            model.addAttribute("msg", ex.getMessage());
        }

        model.addAttribute("researcherForm", researcher);
        populateDefaultModel(model);
        return "researchers/researcher-form";
    }

    /**
     * Saves the new objects related to Researcher
     *
     * @param r
     *
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

    private JSONObject getResearchRelationsGraph() {
        List<Researcher> allResearchers = researcherService.findAll();
        List<Experiment> allExperiments = experimentService.findAll();
        JSONObject object = new JSONObject();
        JSONObject researchers = new JSONObject();
        JSONObject researchRelations = new JSONObject();
        for (Researcher researcher : allResearchers) {
            JSONObject node = new JSONObject();
            node.put("name", researcher.getDisplayName());
            node.put("img", researcher.getPhoto());
            researchers.put(researcher.getId(), node);
        }

        for (Experiment experiment : allExperiments) {
            JSONObject experimentJson = new JSONObject();
            researchRelations.put("experiment_" + experiment.getId(), experimentJson);
            for (Researcher researcher2 : experiment.getResearchers()) {
                if (experiment.getAuthor().getId() != researcher2.getId()) {
                    JSONObject peer = new JSONObject();
                    peer.put("id_1", experiment.getAuthor().getDisplayName());
                    peer.put("id_2", researcher2.getDisplayName());
                    Integer.compare(experiment.getAuthor().getId(), researcher2.getId());
                    experimentJson.put(experiment.getAuthor().getId() + "_" + researcher2.getId(), peer);
                }

            }
        }
        object.put("nodes", researchers);
        object.put("relations", researchRelations);
        return object;
    }

    private JSONObject getResearchExperimentsChart() {
//        try {
        List<Researcher> allResearchers = researcherService.findAll();

        JSONArray relations = new JSONArray();
        for (Researcher researcher : allResearchers) {
            JSONObject relation = new JSONObject();
            relation.put("label", researcher.getDisplayName());
            List<Experiment> experiments = experimentService.findByAuthorId(researcher.getId());
            JSONArray array = new JSONArray();
            for (Experiment experiment : experiments) {
                JSONObject experimentObj = new JSONObject();
                experimentObj.put("label", experiment.getName());
                experimentObj.put("value", 1);
                array.add(experimentObj);
            }
            relation.put("values", array);
            if (experiments.size() > 0) {
                relations.add(relation);
            }
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("content", relations);
        return jsonObject;
//            JSONObject jsonObject = new JSONObject();
//            jsonObject.put("content", new JSONParser().parse("["
//                    + "	{"
//                    + "	  \"label\": \"Region-a\","
//                    + "	  \"values\": ["
//                    + "		{\"label\": \"Ash\", \"value\": 4},"
//                    + "		{\"label\": \"Birch\", \"value\": 3},"
//                    + "		{\"label\": \"Maple\", \"value\": 1}"
//                    + "	  ]"
//                    + "	},"
//                    + "	{"
//                    + "	  \"label\": \"Region-b\","
//                    + "	  \"values\": ["
//                    + "		{\"label\": \"Ash\", \"value\": 3},"
//                    + "		{\"label\": \"Birch\", \"value\": 1},"
//                    + "		{\"label\": \"Maple\", \"value\": 1}"
//                    + "	  ]"
//                    + "	},"
//                    + "	{"
//                    + "	  \"label\": \"Region-c\","
//                    + "	  \"values\": ["
//                    + "		{\"label\": \"Ash\", \"value\": 4},"
//                    + "		{\"label\": \"Birch\", \"value\": 3}"
//                    + "	  ]"
//                    + "	},"
//                    + "	{"
//                    + "	  \"label\": \"Region-d\","
//                    + "	  \"values\": ["
//                    + "		{\"label\": \"Maple\", \"value\": 1},"
//                    + "		{\"label\": \"Ash\", \"value\": null},"
//                    + "		{\"label\": \"Birch\", \"value\": 2}"
//                    + "	  ]"
//                    + "	}"
//                    + "]"));
//            return jsonObject;
//        } catch (ParseException ex) {
//            ex.printStackTrace();
////            Logger.getLogger(ResearchersController.class.getName()).log(Level.SEVERE, null, ex);
//            return new JSONObject();
//        }
    }
}
