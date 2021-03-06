package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.service.ImportProvenanceDataService;
import br.ufjf.pgcc.eseco.app.service.ProvSeOGetInferencesService;
import br.ufjf.pgcc.eseco.app.validator.ExperimentFormValidator;
import br.ufjf.pgcc.eseco.domain.model.experiment.Detail;
import br.ufjf.pgcc.eseco.domain.model.experiment.DetailGroup;
import br.ufjf.pgcc.eseco.domain.model.experiment.Experiment;
import br.ufjf.pgcc.eseco.domain.model.experiment.ExperimentPhase;
import br.ufjf.pgcc.eseco.domain.model.experiment.ExperimentStatus;
import br.ufjf.pgcc.eseco.domain.model.experiment.Workflow;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.core.DisciplineService;
import br.ufjf.pgcc.eseco.domain.service.core.InstitutionService;
import br.ufjf.pgcc.eseco.domain.service.core.ResearchGroupService;
import br.ufjf.pgcc.eseco.domain.service.core.ResearcherService;
import br.ufjf.pgcc.eseco.domain.service.experiment.DetailGroupService;
import br.ufjf.pgcc.eseco.domain.service.experiment.ExperimentService;
import br.ufjf.pgcc.eseco.domain.service.experiment.WorkflowService;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@SessionAttributes({"experimentForm"})
public class ExperimentsController {

    private static final Logger LOGGER = Logger.getLogger(ExperimentsController.class.getName());

    @Autowired
    ExperimentFormValidator experimentFormValidator;

    private ExperimentService experimentService;
    private DisciplineService disciplineService;
    private InstitutionService institutionService;
    private ResearcherService researcherService;
    private ResearchGroupService researchGroupService;
    private WorkflowService workflowService;
    private ImportProvenanceDataService importProvenanceDataService;
    private ProvSeOGetInferencesService provSeOGetInferencesService;
    private DetailGroupService detailGroupService;

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(experimentFormValidator);
    }

    @Autowired
    public void setExperimentService(ExperimentService experimentService, DisciplineService disciplineService,
            InstitutionService institutionService, ResearcherService researcherService, ResearchGroupService researchGroupService,
            WorkflowService workflowService, ImportProvenanceDataService importProvenanceDataService,
            ProvSeOGetInferencesService provSeOGetInferencesService, DetailGroupService detailGroupService) {
        this.experimentService = experimentService;
        this.disciplineService = disciplineService;
        this.institutionService = institutionService;
        this.researcherService = researcherService;
        this.researchGroupService = researchGroupService;
        this.workflowService = workflowService;
        this.importProvenanceDataService = importProvenanceDataService;
        this.provSeOGetInferencesService = provSeOGetInferencesService;
        this.detailGroupService = detailGroupService;
    }

    @RequestMapping(value = "/experiments", method = RequestMethod.GET)
    public String showAllExperiments(Model model, HttpSession session) {

        LOGGER.info("showAllExperiments()");

        // Get all experiments
        List<Experiment> experimentsPhase01 = experimentService.findByPhase(ExperimentPhase.PROBLEM_INVESTIGATION);
        List<Experiment> experimentsPhase02 = experimentService.findByPhase(ExperimentPhase.EXPERIMENT_PROTOTYPING);
        List<Experiment> experimentsPhase03 = experimentService.findByPhase(ExperimentPhase.EXPERIMENT_EXECUTION);
        List<Experiment> experimentsPhase04 = experimentService.findByPhase(ExperimentPhase.RESULTS_PUBLICATION);
        List<Experiment> experimentsPhase05 = experimentService.findByPhase(ExperimentPhase.EXPERIMENT_FINISHED);

        model.addAttribute("experimentsPhase01", experimentsPhase01);
        model.addAttribute("experimentsPhase02", experimentsPhase02);
        model.addAttribute("experimentsPhase03", experimentsPhase03);
        model.addAttribute("experimentsPhase04", experimentsPhase04);
        model.addAttribute("experimentsPhase05", experimentsPhase05);

        return "experiments/list";
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

        List<Detail> details = new ArrayList<>();
        details.add(new Detail());
        experiment.setDetails(details);
        model.addAttribute("experimentForm", experiment);
        populateDefaultModel(model, ExperimentStatus.IN_PROGRESS, ExperimentPhase.PROBLEM_INVESTIGATION);

        return "experiments/experiments-form";
    }

    @RequestMapping(value = "/experiments/addDetail", method = RequestMethod.POST)
    public String addDetail(@ModelAttribute("experimentForm") Experiment experiment, Model model, HttpSession session) {

        LOGGER.info("addDetail()");

        List<Detail> details = experiment.getDetails();
        details.add(new Detail());
        experiment.setDetails(details);
        model.addAttribute("experimentForm", experiment);
        populateDefaultModel(model, experiment.getStatus(), experiment.getCurrentPhase());

        return "experiments/experiments-form";
    }

    @RequestMapping(value = "/experiments/addDetailGroup", method = RequestMethod.POST)
    public String addDetailGroup(@RequestParam("groupId") int groupId, @ModelAttribute("experimentForm") Experiment experiment, Model model, HttpSession session) {

        LOGGER.info("addDetailGroup()");

        List<Detail> details = experiment.getDetails();
        DetailGroup detailGroup = detailGroupService.find(groupId);
        for (String detail : detailGroup.getDetailsList()) {
            Detail d = new Detail();
            d.setName(detail);
            details.add(d);
        }
        experiment.setDetails(details);
        experiment.setDetailGroup(detailGroup);
        model.addAttribute("experimentForm", experiment);
        populateDefaultModel(model, experiment.getStatus(), experiment.getCurrentPhase());

        return "experiments/experiments-form";
    }

    @RequestMapping(value = "/experiments/removeDetail", method = RequestMethod.POST)
    public String removeDetail(@ModelAttribute("experimentForm") Experiment experiment, @RequestParam("index") int index, Model model, HttpSession session) {

        LOGGER.info("removeDetail()");

        if (experiment.getDetails().size() > 1) {
            experiment.getDetails().remove(index);
        } else {
            experiment.getDetails().set(index, new Detail());
        }
        model.addAttribute("experimentForm", experiment);
        populateDefaultModel(model, experiment.getStatus(), experiment.getCurrentPhase());

        return "experiments/experiments-form";
    }

    @RequestMapping(value = "/experiments/{id}/update", method = RequestMethod.GET)
    public String showUpdateExperimentForm(@PathVariable("id") int id, Model model) {

        LOGGER.log(Level.INFO, "showUpdateExperimentForm() : {0}", id);

        Experiment experiment = experimentService.find(id);
        experiment.setDateUpdated(new Date());
        if (experiment.getDetails() == null || experiment.getDetails().isEmpty()) {
            List<Detail> details = new ArrayList<>();
            details.add(new Detail());
            experiment.setDetails(details);
        }
        model.addAttribute("experimentForm", experiment);

        populateDefaultModel(model, experiment.getStatus(), experiment.getCurrentPhase());

        return "experiments/experiments-form";
    }

    @RequestMapping(value = "/experiments", method = RequestMethod.POST)
    public String saveOrUpdateExperiment(@ModelAttribute("experimentForm") @Validated Experiment experiment,
            BindingResult result, Model model, final RedirectAttributes redirectAttributes) {

        LOGGER.log(Level.INFO, "saveOrUpdateExperiment() : {0}", experiment);

        if (result.hasErrors()) {
            populateDefaultModel(model, experiment.getStatus(), experiment.getCurrentPhase());
            return "experiments/experiments-form";
        } else {
            redirectAttributes.addFlashAttribute("css", "success");
            if (experiment.isNew()) {
                redirectAttributes.addFlashAttribute("msg", "Experiment added successfully!");
            } else {
                redirectAttributes.addFlashAttribute("msg", "Experiment updated successfully!");
            }

            try {
                if(experiment.getDetailGroup().isNew()){
                    experiment.setDetailGroup(null);
                }
                ArrayList<Detail> details = new ArrayList<>();
                for (Detail d : experiment.getDetails()) {
                    if (d.getName() != null && !d.getName().isEmpty()) {
                        details.add(d);
                    }
                }
                experiment.setDetails(details);

                experiment = experimentService.saveOrUpdate(experiment);
                return "redirect:/experiments/" + experiment.getId();
            } catch (Exception ex) {
                Logger.getLogger(ExperimentsController.class.getName()).log(Level.SEVERE, null, ex);
                populateDefaultModel(model, experiment.getStatus(), experiment.getCurrentPhase());
                model.addAttribute("msg", ex.getMessage());
                model.addAttribute("css", "danger");
                return "experiments/experiments-form";
            }
        }
    }

    @RequestMapping(value = "/experiments/{id}/delete", method = RequestMethod.POST)
    public String deleteExperiment(@PathVariable("id") int id, final RedirectAttributes redirectAttributes) {

        LOGGER.log(Level.INFO, "deleteExperiment() : {0}", id);

        Experiment experiment = experimentService.find(id);
        try {
            experimentService.delete(experiment);
        } catch (Exception ex) {
            redirectAttributes.addFlashAttribute("css", "danger");
            redirectAttributes.addFlashAttribute("msg", ex.getMessage());
            Logger.getLogger(ExperimentsController.class.getName()).log(Level.SEVERE, null, ex);
        }

        redirectAttributes.addFlashAttribute("css", "success");
        redirectAttributes.addFlashAttribute("msg", "Experiment is deleted!");

        return "redirect:/experiments";
    }

    @RequestMapping(value = "/experiments/{id}", method = RequestMethod.GET)
    public String showExperiment(@PathVariable("id") int id, Model model, HttpSession session, HttpServletRequest request) {

        LOGGER.log(Level.INFO, "showExperiment() id: {0}", id);

        Experiment experiment = experimentService.find(id);
        if (experiment == null) {
            model.addAttribute("css", "danger");
            model.addAttribute("msg", "Experiment not found");
        }
        try {
            JSONObject experimentProvenanceJSON = provSeOGetInferencesService.getProvenanceOntologyService(request.getHeader("host"), "experiment." + experiment.getId());
            model.addAttribute("experimentProvenanceJSON", experimentProvenanceJSON);
        } catch (IOException ex) {
            Logger.getLogger(OntologyController.class.getName()).log(Level.SEVERE, null, ex);
        }

        model.addAttribute("experiment", experiment);
        setSessionCurrentPhase(session, experiment);
        return "experiments/show";
    }

    @RequestMapping(value = "/experiments/{id}/addProvenance", method = RequestMethod.GET)
    public String showAddProvenanceDataForm(@PathVariable("id") int id, Model model, HttpSession session) {

        LOGGER.log(Level.INFO, "showAddProvenanceDataForm() : {0}", id);

        Experiment experiment = experimentService.find(id);
        model.addAttribute("experimentForm", experiment);
        model.addAttribute("workflowsList", experiment.getWorkflows());
        return "experiments/experiments-add-provenance-data-form";
    }

    @RequestMapping(value = "/experiments/saveProvenance", method = RequestMethod.POST)
    public String saveProvenanceData(@ModelAttribute("experimentForm") Experiment experiment,
            @RequestParam("fileToUpload") MultipartFile file, Model model, BindingResult result,
            final RedirectAttributes redirectAttributes, HttpSession session) {

        LOGGER.log(Level.INFO, "saveProvenanceData() : {0}", experiment);
        User user = (User) session.getAttribute("logged_user");

        if (file.isEmpty()) {
            redirectAttributes.addFlashAttribute("css", "danger");
            redirectAttributes.addFlashAttribute("msg", "Please select a file to upload!");
            return "redirect:/experiments/" + experiment.getId() + "/addProvenance";
        }
        if (experiment.getWorkflows().size() != 1) {
            result.addError(new FieldError("workflows", "workflows", " Please select the Workflow!"));
            experiment = experimentService.find(experiment.getId());
            model.addAttribute("experimentForm", experiment);
            model.addAttribute("workflowsList", experiment.getWorkflows());
            return "experiments/experiments-add-provenance-data-form";
        }

        Workflow workflow = workflowService.find(experiment.getWorkflows().iterator().next().getId());
        try {
            importProvenanceDataService.importProvenanceData(experiment, workflow, file.getBytes(), user.getAgent().getResearcher());
            redirectAttributes.addFlashAttribute("css", "success");
            redirectAttributes.addFlashAttribute("msg", "Provenance Data successfully imported!");
            return "redirect:/experiments/" + experiment.getId();

        } catch (Exception ex) {
            redirectAttributes.addFlashAttribute("css", "danger");
            redirectAttributes.addFlashAttribute("msg", ex.getMessage());
            LOGGER.log(Level.SEVERE, ex.getMessage());
            return "redirect:/experiments/" + experiment.getId() + "/addProvenance";
        }
    }

    private void populateDefaultModel(Model model, ExperimentStatus status, ExperimentPhase phase) {

        List<ExperimentStatus> statusList = new ArrayList<>();
        statusList.add(status);
        List<ExperimentPhase> phaseList = new ArrayList<>();
        phaseList.add(phase);

        model.addAttribute("statusList", statusList);
        model.addAttribute("phaseList", phaseList);
        model.addAttribute("disciplinesList", disciplineService.findAll());
        model.addAttribute("institutionsList", institutionService.findAll());
        model.addAttribute("researchesList", researcherService.findAll());
        model.addAttribute("researchGroupsList", researchGroupService.findAll());
        model.addAttribute("workflowsList", workflowService.findAll());
        model.addAttribute("detailsGroupList", detailGroupService.findAll());
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
