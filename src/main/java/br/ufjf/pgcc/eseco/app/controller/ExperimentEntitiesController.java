package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.validator.ExperimentEntityFormValidator;
import br.ufjf.pgcc.eseco.domain.model.experiment.Data;
import br.ufjf.pgcc.eseco.domain.model.experiment.Document;
import br.ufjf.pgcc.eseco.domain.model.experiment.Entity;
import br.ufjf.pgcc.eseco.domain.model.experiment.EntityKind;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowService;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.experiment.DataService;
import br.ufjf.pgcc.eseco.domain.service.experiment.DocumentService;
import br.ufjf.pgcc.eseco.domain.service.experiment.EntityService;
import java.util.Date;
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
@SessionAttributes({"entityForm"})
public class ExperimentEntitiesController {

    private static final Logger LOGGER = Logger.getLogger(ExperimentEntitiesController.class.getName());

    @Autowired
    ExperimentEntityFormValidator entityFormValidator;

    private EntityService entityService;
    private DataService dataService;
    private DocumentService documentService;

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(entityFormValidator);
    }

    @Autowired
    public void setEntityService(EntityService entityService, DataService dataService,
            DocumentService documentService) {
        this.entityService = entityService;
        this.dataService = dataService;
        this.documentService = documentService;
    }

    @RequestMapping(value = "/experiments/entities", method = RequestMethod.GET)
    public String showAllEntities(Model model) {

        LOGGER.info("showAllEntities()");
        model.addAttribute("entities", entityService.findAll());

        return "experiments/entities/list";
    }

    @RequestMapping(value = "/experiments/entities/add", method = RequestMethod.GET)
    public String showAddEntityForm(Model model, HttpSession session) {

        LOGGER.info("showAddEntityForm()");

        Entity entity = new Entity();
        entity.setData(new Data());
        entity.setDocument(new Document());
        model.addAttribute("entityForm", entity);
        populateDefaultModel(model);
        return "experiments/entities/entities-form";
    }

    @RequestMapping(value = "/experiments/entities/{id}/update", method = RequestMethod.GET)
    public String showUpdateEntityForm(@PathVariable("id") int id, Model model) {

        LOGGER.log(Level.INFO, "showUpdateEntityForm() : {0}", id);

        Entity entity = entityService.find(id);
        model.addAttribute("entityForm", entity);

        populateDefaultModel(model);
        return "experiments/entities/entities-form";
    }

    @RequestMapping(value = "/experiments/entities", method = RequestMethod.POST)
    public String saveOrUpdateEntity(@ModelAttribute("entityForm") @Validated Entity entity,
            BindingResult result, Model model, final RedirectAttributes redirectAttributes, HttpSession session) {

        LOGGER.log(Level.INFO, "saveOrUpdateEntity() : {0}", entity);

        if (result.hasErrors()) {
            populateDefaultModel(model);
            return "experiments/entities/entities-form";
        } else {
            redirectAttributes.addFlashAttribute("css", "success");
            if (entity.isNew()) {
                redirectAttributes.addFlashAttribute("msg", "Entity added successfully!");
            } else {
                redirectAttributes.addFlashAttribute("msg", "Entity updated successfully!");
            }

            try {
                if (entity.getKind().equals(EntityKind.DATA)) {
                    Data data = dataService.saveOrUpdate(entity.getData());
                    entity.setData(data);
                } else if (entity.getKind().equals(EntityKind.DOCUMENT)) {
                    Document document = documentService.saveOrUpdate(entity.getDocument());
                    entity.setDocument(document);
                }
                entity = entityService.saveOrUpdate(entity);
                return "redirect:/experiments/entities/" + entity.getId();
            } catch (Exception ex) {
                LOGGER.log(Level.SEVERE, null, ex);
                populateDefaultModel(model);
                return "experiments/entities/entities-form";
            }
        }
    }

    @RequestMapping(value = "/experiments/entities/{id}/delete", method = RequestMethod.POST)
    public String deleteEntity(@PathVariable("id") int id, final RedirectAttributes redirectAttributes) {

        LOGGER.log(Level.INFO, "deleteEntity() : {0}", id);

        Entity entity = entityService.find(id);
        try {

            if (entity.getData() != null) {
                dataService.delete(entity.getData());
            }
            if (entity.getDocument() != null) {
                documentService.delete(entity.getDocument());
            }
            entityService.delete(entity);
            redirectAttributes.addFlashAttribute("css", "success");
            redirectAttributes.addFlashAttribute("msg", "Entity has been deleted!");
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, null, ex);
            redirectAttributes.addFlashAttribute("css", "danger");
            redirectAttributes.addFlashAttribute("msg", ex.getMessage());
        }

        return "redirect:/experiments/entities";
    }

    @RequestMapping(value = "/experiments/entities/{id}", method = RequestMethod.GET)
    public String showEntity(@PathVariable("id") int id, Model model, HttpSession session) {

        LOGGER.log(Level.INFO, "showEntity() id: {0}", id);

        Entity entity = entityService.find(id);
        if (entity == null) {
            model.addAttribute("css", "danger");
            model.addAttribute("msg", "Entity not found");
        }

        model.addAttribute("entity", entity);
        return "experiments/entities/show";

    }

    /**
     * Populates the lists of objects required to listbox items
     *
     * @param model
     */
    private void populateDefaultModel(Model model) {
        model.addAttribute("kindList", EntityKind.getList());
    }

}
