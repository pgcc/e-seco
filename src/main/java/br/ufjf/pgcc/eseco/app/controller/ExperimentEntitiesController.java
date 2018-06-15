package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.service.FileUploadService;
import br.ufjf.pgcc.eseco.app.validator.ExperimentEntityFormValidator;
import br.ufjf.pgcc.eseco.domain.model.experiment.Data;
import br.ufjf.pgcc.eseco.domain.model.experiment.Document;
import br.ufjf.pgcc.eseco.domain.model.experiment.Entity;
import br.ufjf.pgcc.eseco.domain.model.experiment.EntityKind;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.experiment.DataService;
import br.ufjf.pgcc.eseco.domain.service.experiment.DocumentService;
import br.ufjf.pgcc.eseco.domain.service.experiment.EntityService;
import java.awt.FileDialog;
import java.awt.Frame;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
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

        User user = (User) session.getAttribute("logged_user");

        Entity entity = new Entity();
        entity.setAuthor(user.getAgent().getResearcher());
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
    public String saveOrUpdateEntity(@ModelAttribute("entityForm") Entity entity,
            @RequestParam("fileToUpload") MultipartFile file, BindingResult result,
            Model model, final RedirectAttributes redirectAttributes) {

        LOGGER.log(Level.INFO, "saveOrUpdateEntity() : {0}", entity);

        if (entity.getName().isEmpty()) {
            result.addError(new FieldError("name", "name", "Name is required!"));
        }
        if (entity.getKind() == null) {
            result.addError(new FieldError("kind", "kind", " Please select the Entity kind!"));
        }
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
                    entity.setDocument(null);
                    Data data = entity.getData();
                    data.setEntity(entity);
                } else if (entity.getKind().equals(EntityKind.DOCUMENT)) {
                    entity.setData(null);
                    Document document = entity.getDocument();
                    document.setEntity(entity);
                    if (entity.isNew()) {
                        if (file.isEmpty()) {
                            result.addError(new FieldError("document.file", "document.file", "Please select a file to upload!"));
                            populateDefaultModel(model);
                            return "experiments/entities/entities-form";
                        }
                        try {
                            byte[] bytes = file.getBytes();
                            String folderName = "author_" + entity.getAuthor().getId();
                            String upload = FileUploadService.upload(folderName, file.getOriginalFilename(), bytes);
                            entity.getDocument().setFile(upload);
                        } catch (Exception e) {
                            LOGGER.log(Level.SEVERE, null, e);
                            model.addAttribute("css", "danger");
                            model.addAttribute("msg", "Could not upload file!");
                            populateDefaultModel(model);
                            return "experiments/entities/entities-form";
                        }
                    }
                }
                entity = entityService.saveOrUpdate(entity);
                return "redirect:/experiments/entities/" + entity.getId();
            } catch (Exception ex) {
                LOGGER.log(Level.SEVERE, null, ex);
                model.addAttribute("css", "danger");
                model.addAttribute("msg", "Could not save Entity!");
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
                File file = new File(entity.getDocument().getFile());
                if (file.exists()) {
                    file.delete();
                }
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

    @RequestMapping(value = "/experiments/entities/{id}/download", method = RequestMethod.GET)
    public String downloadFile(@PathVariable("id") int id, HttpServletResponse response, Model model, final RedirectAttributes redirectAttributes) {

        Entity entity = entityService.find(id);
        if (entity.getDocument() == null) {
            model.addAttribute("entity", entity);
            return "experiments/entities/show";
        }

        File file = new File(entity.getDocument().getFile());

        if (!file.exists()) {
            redirectAttributes.addFlashAttribute("css", "danger");
            redirectAttributes.addFlashAttribute("msg", "Sorry. The file you are looking for does not exist");
            return "redirect:/experiments/entities/" + entity.getId();
        }
        try {
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", String.format("inline; filename=\"" + file.getName() + "\""));
            response.setContentLength((int) file.length());
            InputStream inputStream = new BufferedInputStream(new FileInputStream(file));
            FileCopyUtils.copy(inputStream, response.getOutputStream());

        } catch (Exception e) {
            e.printStackTrace();;
        }
        return "";
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
