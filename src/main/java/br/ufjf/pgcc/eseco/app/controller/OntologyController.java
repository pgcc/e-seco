package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.service.ProvSeOExportDataService;
import br.ufjf.pgcc.eseco.app.validator.ExperimentFormValidator;
import java.util.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class OntologyController {

    private static final Logger LOGGER = Logger.getLogger(OntologyController.class.getName());

    @Autowired
    ExperimentFormValidator experimentFormValidator;


    private ProvSeOExportDataService provSeOExportDataService;

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(experimentFormValidator);
    }

    @Autowired
    public void setOntologyService(ProvSeOExportDataService provSeOExportDataService) {
        this.provSeOExportDataService =  provSeOExportDataService;
    }

    @RequestMapping(value = "/ontology", method = RequestMethod.GET)
    public String callOntologyService(Model model) {

        LOGGER.info("callOntologyService()");

        provSeOExportDataService.getData();

        return "redirect:/experiments";
    }
}
