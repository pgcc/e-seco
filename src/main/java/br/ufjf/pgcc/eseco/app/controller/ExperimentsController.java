package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.service.ImportProvenanceDataService;
import br.ufjf.pgcc.eseco.app.validator.ExperimentFormValidator;
import br.ufjf.pgcc.eseco.domain.model.core.Discipline;
import br.ufjf.pgcc.eseco.domain.model.core.Institution;
import br.ufjf.pgcc.eseco.domain.model.core.ResearchGroup;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import br.ufjf.pgcc.eseco.domain.model.experiment.Experiment;
import br.ufjf.pgcc.eseco.domain.model.experiment.ExperimentPhase;
import br.ufjf.pgcc.eseco.domain.model.experiment.ExperimentStatus;
import br.ufjf.pgcc.eseco.domain.model.experiment.Workflow;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.core.DisciplineService;
import br.ufjf.pgcc.eseco.domain.service.core.InstitutionService;
import br.ufjf.pgcc.eseco.domain.service.core.ResearchGroupService;
import br.ufjf.pgcc.eseco.domain.service.core.ResearcherService;
import br.ufjf.pgcc.eseco.domain.service.experiment.ExperimentService;
import br.ufjf.pgcc.eseco.domain.service.experiment.WorkflowService;
import java.awt.FileDialog;
import java.awt.Frame;
import java.io.File;
import java.io.FilenameFilter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@SessionAttributes({"experimentForm"})
public class ExperimentsController {

    private static final Logger LOGGER = Logger.getLogger(ExperimentsController.class.getName());

    @Autowired
    ExperimentFormValidator experimentFormValidator;

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(experimentFormValidator);
    }

    private ExperimentService experimentService;
    private DisciplineService disciplineService;
    private InstitutionService institutionService;
    private ResearcherService researcherService;
    private ResearchGroupService researchGroupService;
    private WorkflowService workflowService;
    private ImportProvenanceDataService importProvenanceDataService;

    @Autowired
    public void setExperimentService(ExperimentService experimentService, DisciplineService disciplineService,
            InstitutionService institutionService, ResearcherService researcherService, ResearchGroupService researchGroupService,
            WorkflowService workflowService, ImportProvenanceDataService importProvenanceDataService) {
        this.experimentService = experimentService;
        this.disciplineService = disciplineService;
        this.institutionService = institutionService;
        this.researcherService = researcherService;
        this.researchGroupService = researchGroupService;
        this.workflowService = workflowService;
        this.importProvenanceDataService = importProvenanceDataService;
    }

    @RequestMapping(value = "/experiments", method = RequestMethod.GET)
    public String showAllExperiments(Model model) {

        LOGGER.info("showAllExperiments()");
        model.addAttribute("experiments", experimentService.findAll());
        return "experiments/list";

    }

    @RequestMapping(value = "/experiments", method = RequestMethod.POST)
    public String saveOrUpdateExperiment(@ModelAttribute("experimentForm") @Validated Experiment experiment,
            BindingResult result, Model model, final RedirectAttributes redirectAttributes) {

        LOGGER.log(Level.INFO, "saveOrUpdateExperiment() : {0}", experiment);

        if (result.hasErrors()) {
            populateDefaultModel(model);
            return "experiments/experiments-form";
        } else {
            redirectAttributes.addFlashAttribute("css", "success");
            if (experiment.isNew()) {
                redirectAttributes.addFlashAttribute("msg", "Experiment added successfully!");
            } else {
                redirectAttributes.addFlashAttribute("msg", "Experiment updated successfully!");
            }

            try {
                experiment = experimentService.saveOrUpdate(experiment);
                return "redirect:/experiments/" + experiment.getId();
            } catch (Exception ex) {
                Logger.getLogger(ExperimentsController.class.getName()).log(Level.SEVERE, null, ex);
                populateDefaultModel(model);
                return "experiments/experiments-form";
            }

        }

    }

    @RequestMapping(value = "/experiments/add", method = RequestMethod.GET)
    public String showAddExperimentForm(Model model, HttpSession session) {

        LOGGER.info("showAddExperimentForm()");

        User user = (User) session.getAttribute("logged_user");

        Experiment experiment = new Experiment();

        // set default value
        experiment.setAuthor(user.getAgent().getResearcher());
        experiment.setDateCreated(new Date());
        experiment.setStatus(ExperimentStatus.IN_PROGRESS);
        experiment.setCurrentPhase(ExperimentPhase.PROBLEM_INVESTIGATION);
        experiment.setVersion("1.0.0");

        model.addAttribute("experimentForm", experiment);

        populateDefaultModel(model);

        return "experiments/experiments-form";

    }

    @RequestMapping(value = "/experiments/{id}/update", method = RequestMethod.GET)
    public String showUpdateExperimentForm(@PathVariable("id") int id, Model model) {

        LOGGER.log(Level.INFO, "showUpdateExperimentForm() : {0}", id);

        Experiment experiment = experimentService.find(id);
        model.addAttribute("experimentForm", experiment);

        populateDefaultModel(model);

        return "experiments/experiments-form";

    }

    @RequestMapping(value = "/experiments/{id}/delete", method = RequestMethod.POST)
    public String deleteExperiment(@PathVariable("id") int id, final RedirectAttributes redirectAttributes) {

        LOGGER.log(Level.INFO, "deleteExperiment() : {0}", id);

        Experiment experiment = experimentService.find(id);
        try {
            experimentService.delete(experiment);
        } catch (Exception ex) {
            Logger.getLogger(ExperimentsController.class.getName()).log(Level.SEVERE, null, ex);
        }

        redirectAttributes.addFlashAttribute("css", "success");
        redirectAttributes.addFlashAttribute("msg", "Experiment is deleted!");

        return "redirect:/experiments";

    }

    @RequestMapping(value = "/experiments/{id}", method = RequestMethod.GET)
    public String showExperiment(@PathVariable("id") int id, Model model, HttpSession session) {

        LOGGER.log(Level.INFO, "showExperiment() id: {0}", id);

        Experiment experiment = experimentService.find(id);
        if (experiment == null) {
            model.addAttribute("css", "danger");
            model.addAttribute("msg", "Experiment not found");
        }

        model.addAttribute("experiment", experiment);

        setSessionCurrentPhase(session, experiment);

        return "experiments/show";

    }

    @RequestMapping(value = "/experiments/{id}/addProvenance", method = RequestMethod.GET)
    public String showAddProvenanceDataForm(@PathVariable("id") int id, Model model) {

        LOGGER.log(Level.INFO, "showAddProvenanceDataForm() : {0}", id);

        Experiment experiment = experimentService.find(id);
        model.addAttribute("experimentForm", experiment);

        model.addAttribute("workflowsList", experiment.getWorkflows());

        return "experiments/experiments-add-provenance-data-form";

    }

    @RequestMapping(value = "/experiments/{id}/addProvenance", method = RequestMethod.POST)
    public String chooseProvenanceDataFile(@PathVariable("id") int id, @ModelAttribute("experimentForm") Experiment experiment, Model model) {

        LOGGER.log(Level.INFO, "chooseProvenanceDataFile() : {0}", id);

        FileDialog fileDialog = new FileDialog(new Frame(), "Open", FileDialog.LOAD);
        fileDialog.setFile("*.json");
        fileDialog.setFilenameFilter(new FilenameFilter() {
            @Override
            public boolean accept(File dir, String name) {
                return name.endsWith(".json");
            }
        });

        fileDialog.setFocusable(true);
        fileDialog.setVisible(true);
        fileDialog.toFront();
        model.addAttribute("file", fileDialog.getDirectory() + fileDialog.getFile());
        model.addAttribute("workflowsList", experimentService.find(id).getWorkflows());
        return "experiments/experiments-add-provenance-data-form";

    }

    @RequestMapping(value = "/experiments/saveProvenance", method = RequestMethod.POST)
    public String saveProvenanceData(@ModelAttribute("experimentForm") Experiment experiment, @RequestParam(value = "file") String file, Model model, final RedirectAttributes redirectAttributes) {

        LOGGER.log(Level.INFO, "saveProvenanceData() : {0}", experiment);

        if (experiment.getWorkflows().size() == 1 && !file.isEmpty()) {
            Workflow workflow = workflowService.find(experiment.getWorkflows().get(0).getId());
            try {
                importProvenanceDataService.importProvenanceData(experiment, workflow, file);
                redirectAttributes.addFlashAttribute("css", "success");
                redirectAttributes.addFlashAttribute("msg", "Prevenance data successfully imported!");
                return "redirect:/experiments/" + experiment.getId();

            } catch (Exception ex) {
                LOGGER.log(Level.SEVERE, ex.getMessage());
            }

        }
        model.addAttribute("file", file);
        model.addAttribute("experimentForm", experiment);
        model.addAttribute("workflowsList", experimentService.find(experiment.getId()).getWorkflows());
        return "experiments/experiments-add-provenance-data-form";
    }

    private void populateDefaultModel(Model model) {

        model.addAttribute("statusList", ExperimentStatus.getList());
        model.addAttribute("phaseList", ExperimentPhase.getList());

        Map<Integer, String> disciplines = new HashMap<>();
        for (Discipline discipline : disciplineService.findAll()) {
            disciplines.put(discipline.getId(), discipline.getName());
        }
        model.addAttribute("disciplinesList", disciplines);

        List<Institution> institutions = institutionService.findAll();
        model.addAttribute("institutionsList", institutions);

        List<Researcher> researches = researcherService.findAll();
        model.addAttribute("researchesList", researches);

        List<ResearchGroup> researchGroups = researchGroupService.findAll();
        model.addAttribute("researchGroupsList", researchGroups);

        List<Workflow> workflows = workflowService.findAll();
        model.addAttribute("workflowsList", workflows);

    }

    @ExceptionHandler(EmptyResultDataAccessException.class)
    public ModelAndView handleEmptyData(HttpServletRequest req, Exception ex) {

        LOGGER.info("handleEmptyData()");
        LOGGER.log(Level.INFO, "Request: {0}, error {1}", new Object[]{req.getRequestURL(), ex});

        ModelAndView model = new ModelAndView();
        model.setViewName("experiment/show");
        model.addObject("msg", "experiment not found");

        return model;

    }

    private void setSessionCurrentPhase(HttpSession session, Experiment experiment) {
        session.setAttribute("problem_investigation", false);
        session.setAttribute("experiment_prototyping", false);
        session.setAttribute("experiment_execution", false);
        session.setAttribute("results_publication", false);
        session.setAttribute("experiment_finished", false);
        switch (experiment.getCurrentPhase()) {
            case PROBLEM_INVESTIGATION:
                session.setAttribute("problem_investigation", true);
                break;
            case EXPERIMENT_PROTOTYPING:
                session.setAttribute("experiment_prototyping", true);
                break;
            case EXPERIMENT_EXECUTION:
                session.setAttribute("experiment_execution", true);
                break;
            case RESULTS_PUBLICATION:
                session.setAttribute("results_publication", true);
                break;
            case EXPERIMENT_FINISHED:
                session.setAttribute("experiment_finished", true);
                break;
            default:
                break;
        }
    }
}
