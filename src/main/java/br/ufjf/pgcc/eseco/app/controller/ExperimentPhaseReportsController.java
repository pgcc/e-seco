package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.validator.ExperimentPhaseReportFormValidator;
import br.ufjf.pgcc.eseco.domain.model.experiment.Experiment;
import br.ufjf.pgcc.eseco.domain.model.experiment.ExperimentPhase;
import br.ufjf.pgcc.eseco.domain.model.experiment.ExperimentPhaseReport;
import br.ufjf.pgcc.eseco.domain.model.experiment.ExperimentStatus;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.core.ResearcherService;
import br.ufjf.pgcc.eseco.domain.service.experiment.ExperimentPhaseReportService;
import br.ufjf.pgcc.eseco.domain.service.experiment.ExperimentService;
import java.util.Date;
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
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@SessionAttributes({"experimentPhaseReportForm"})
public class ExperimentPhaseReportsController {

    private static final Logger LOGGER = Logger.getLogger(ExperimentPhaseReportsController.class.getName());

    @Autowired
    ExperimentPhaseReportFormValidator experimentPhaseReportFormValidator;

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(experimentPhaseReportFormValidator);
    }

    private ExperimentService experimentService;
    private ResearcherService researcherService;
    private ExperimentPhaseReportService experimentPhaseReportService;

    @Autowired
    public void setExperimentPhaseReportService(ExperimentService experimentService, ResearcherService researcherService,
            ExperimentPhaseReportService experimentPhaseReportService) {
        this.experimentService = experimentService;
        this.researcherService = researcherService;
        this.experimentPhaseReportService = experimentPhaseReportService;
    }

    @RequestMapping(value = "/experiments/experimentPhaseReport", method = RequestMethod.POST)
    public String saveOrUpdateExperimentPhaseReport(@ModelAttribute("experimentPhaseReportForm")
            @Validated ExperimentPhaseReport experimentPhaseReport, BindingResult result, Model model,
            final RedirectAttributes redirectAttributes) {

        LOGGER.log(Level.INFO, "saveOrUpdateExperimentPhaseReport() : {0}", experimentPhaseReport);

        if (result.hasErrors()) {
            return "experiments/experiment-phase-report-form";
        } else {
            redirectAttributes.addFlashAttribute("css", "success");
            if (experimentPhaseReport.isNew()) {
                redirectAttributes.addFlashAttribute("msg", "Experiment Phase Report added successfully!");
            } else {
                redirectAttributes.addFlashAttribute("msg", "Experiment Phase Report updated successfully!");
            }

            try {
                experimentPhaseReport = experimentPhaseReportService.saveOrUpdate(experimentPhaseReport);
                Experiment experiment = experimentPhaseReport.getExperiment();
                switch (experiment.getCurrentPhase()) {
                    case PROBLEM_INVESTIGATION:
                        experiment.setCurrentPhase(ExperimentPhase.EXPERIMENT_PROTOTYPING);
                        break;
                    case EXPERIMENT_PROTOTYPING:
                        experiment.setCurrentPhase(ExperimentPhase.EXPERIMENT_EXECUTION);
                        break;
                    case EXPERIMENT_EXECUTION:
                        experiment.setCurrentPhase(ExperimentPhase.RESULTS_PUBLICATION);
                        break;
                    case RESULTS_PUBLICATION:
                        experiment.setCurrentPhase(ExperimentPhase.EXPERIMENT_FINISHED);
                        experiment.setStatus(ExperimentStatus.FINISHED);
                        break;
                }
                experimentService.saveOrUpdate(experiment);
            } catch (Exception ex) {
                Logger.getLogger(ExperimentPhaseReportsController.class.getName()).log(Level.SEVERE, null, ex);
            }

            // POST/FORWARD/GET
            return "redirect:/experiments/" + experimentPhaseReport.getExperiment().getId();

            // POST/FORWARD/GET
            // return "experiment/list";
        }

    }

    @RequestMapping(value = "/experiments/{experimentId}/experimentPhaseReport/add", method = RequestMethod.GET)
    public String showAddExperimentPhaseReportForm(Model model, @PathVariable("experimentId") int experimentId,
            HttpSession session) {

        LOGGER.info("showAddExperimentPhaseReportForm()");

        User user = (User) session.getAttribute("logged_user");
        Experiment experiment = experimentService.find(experimentId);
        ExperimentPhaseReport experimentPhaseReport = new ExperimentPhaseReport();

        // set default value
        experimentPhaseReport.setAuthor(user.getAgent().getResearcher());
        experimentPhaseReport.setDateCreated(new Date());
        experimentPhaseReport.setCurrentPhase(experiment.getCurrentPhase());
        experimentPhaseReport.setExperiment(experiment);

        model.addAttribute("experimentPhaseReportForm", experimentPhaseReport);
        populateDefaultModel(model);
        return "experiments/experiment-phase-report-form";

    }

    @RequestMapping(value = "/experiments/experimentPhaseReport/{id}/update", method = RequestMethod.GET)
    public String showUpdateExperimentPhaseReportForm(@PathVariable("id") int id, Model model) {

        LOGGER.log(Level.INFO, "showUpdateExperimentPhaseReportForm() : {0}", id);

        ExperimentPhaseReport experimentPhaseReport = experimentPhaseReportService.find(id);
        model.addAttribute("experimentPhaseReportForm", experimentPhaseReport);
        populateDefaultModel(model);
        return "experiments/experiment-phase-report-form";

    }

    @RequestMapping(value = "/experiments/experimentPhaseReport/{id}/delete", method = RequestMethod.POST)
    public String deleteExperimentPhaseReport(@PathVariable("id") int id, final RedirectAttributes redirectAttributes) {

        LOGGER.log(Level.INFO, "deleteExperimentPhaseReport() : {0}", id);

        ExperimentPhaseReport experimentPhaseReport = experimentPhaseReportService.find(id);
        try {
            experimentPhaseReportService.delete(experimentPhaseReport);
        } catch (Exception ex) {
            Logger.getLogger(ExperimentPhaseReportsController.class.getName()).log(Level.SEVERE, null, ex);
        }

        redirectAttributes.addFlashAttribute("css", "success");
        redirectAttributes.addFlashAttribute("msg", "Experiment Phase Report is deleted!");

        return "redirect:/experiments";

    }

    @RequestMapping(value = "/experiments/experimentPhaseReport{id}", method = RequestMethod.GET)
    public String showExperimentPhaseReport(@PathVariable("id") int id, Model model) {

        LOGGER.log(Level.INFO, "showExperimentPhaseReport() id: {0}", id);

        ExperimentPhaseReport experimentPhaseReport = experimentPhaseReportService.find(id);
        if (experimentPhaseReport == null) {
            model.addAttribute("css", "danger");
            model.addAttribute("msg", "Experiment Phase Report not found");
        }
        model.addAttribute("experimentPhaseReport", experimentPhaseReport);
        populateDefaultModel(model);
        return "experiments/showPhaseReport";

    }

    private void populateDefaultModel(Model model) {

        model.addAttribute("phaseList", ExperimentPhase.getList());

    }

    @ExceptionHandler(EmptyResultDataAccessException.class)
    public ModelAndView handleEmptyData(HttpServletRequest req, Exception ex) {

        LOGGER.info("handleEmptyData()");
        LOGGER.log(Level.INFO, "Request: {0}, error {1}", new Object[]{req.getRequestURL(), ex});

        ModelAndView model = new ModelAndView();
        model.setViewName("experiment/showPhaseReport");
        model.addObject("msg", "experiment phase report not found");

        return model;

    }
}
