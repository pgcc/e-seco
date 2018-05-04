package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.service.ProvSeOExportDataService;
import br.ufjf.pgcc.eseco.app.service.ProvSeOGetInferencesService;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class OntologyController {

    private static final Logger LOGGER = Logger.getLogger(OntologyController.class.getName());

    private ProvSeOExportDataService provSeOExportDataService;
    private ProvSeOGetInferencesService provSeOGetInferencesService;

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
    }

    @Autowired
    public void setOntologyService(ProvSeOExportDataService provSeOExportDataService, ProvSeOGetInferencesService provSeOGetInferencesService) {
        this.provSeOExportDataService = provSeOExportDataService;
        this.provSeOGetInferencesService = provSeOGetInferencesService;
    }

    @RequestMapping(value = "/ontology", method = RequestMethod.GET)
    public String callOntologyService(Model model, RedirectAttributes redirectAttributes) {

        LOGGER.info("callOntologyService()");

        JsonObject data = provSeOExportDataService.getData();
        try {
            provSeOGetInferencesService.callOntologyService(data);           
            
            redirectAttributes.addFlashAttribute("css", "success");
            redirectAttributes.addFlashAttribute("msg", "Inferences imported successfully!");
        } catch (IOException ex) {
            redirectAttributes.addFlashAttribute("css", "danger");
            redirectAttributes.addFlashAttribute("msg", "Error creating HTTP connection!");
            Logger.getLogger(OntologyController.class.getName()).log(Level.SEVERE, null, ex);
        }

        return "redirect:/experiments";
    }
}
