package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.service.ProvSeOExportDataService;
import br.ufjf.pgcc.eseco.app.service.ProvSeOGetInferencesService;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.ws.http.HTTPException;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
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
    public String callOntologyService(Model model, RedirectAttributes redirectAttributes,
            HttpServletRequest request, HttpSession session) {

        LOGGER.info("callOntologyService()");
        User user = (User) session.getAttribute("logged_user");
        Researcher researcher = user.getAgent().getResearcher();
        JsonObject data = provSeOExportDataService.getData();

        try {
            provSeOGetInferencesService.callOntologyService(request.getHeader("host"), data);

            redirectAttributes.addFlashAttribute("css", "success");
            redirectAttributes.addFlashAttribute("msg", "Inferences imported successfully!");
        } catch (IOException ex) {
            Logger.getLogger(OntologyController.class.getName()).log(Level.SEVERE, null, ex);
            redirectAttributes.addFlashAttribute("css", "danger");
            redirectAttributes.addFlashAttribute("msg", "Error creating HTTP connection! " + ex.getMessage());
        } catch (HTTPException ex) {
            Logger.getLogger(OntologyController.class.getName()).log(Level.SEVERE, null, ex);
            redirectAttributes.addFlashAttribute("css", "danger");
            redirectAttributes.addFlashAttribute("msg", "Error in ontology service. Status code = " + ex.getStatusCode() + "!");

        }
        return "redirect:ontology/researcher_" + researcher.getId();
    }

    @RequestMapping(value = "/ontology/{objectName}", method = RequestMethod.GET)
    public String getOntologyInferencesService(@PathVariable("objectName") String objectName, Model model, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        try {
            objectName = objectName.replace("_", ".");
            JSONObject experimentProvenanceJSON = provSeOGetInferencesService.getProvenanceOntologyService(request.getHeader("host"), objectName);
            if (experimentProvenanceJSON.size() == 0) {
                model.addAttribute("css", "danger");
                model.addAttribute("msg", "Object not found!");
                return "ontology/show_inferences";
            }
            Gson gson = new GsonBuilder().setPrettyPrinting().create();
            JsonParser jp = new JsonParser();
            JsonElement je = jp.parse(experimentProvenanceJSON.toJSONString());
            String prettyJsonString = gson.toJson(je);
            prettyJsonString = prettyJsonString.replaceAll("\\.", "_");
            model.addAttribute("objectName", experimentProvenanceJSON.get("resource"));
            model.addAttribute("objectInferences", prettyJsonString);
            String experimentProvenance = experimentProvenanceJSON.toJSONString().replaceAll("\\\\", "_");
            model.addAttribute("objectInferencesJson", experimentProvenance);
        } catch (IOException ex) {
            Logger.getLogger(OntologyController.class.getName()).log(Level.SEVERE, null, ex);
            redirectAttributes.addFlashAttribute("css", "danger");
            redirectAttributes.addFlashAttribute("msg", ex.getMessage());
        }

        return "ontology/show_inferences";
    }
}
