package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.biocatalogue.exception.BioCatalogueException;
import br.ufjf.pgcc.eseco.app.model.WorkflowServiceSearchResult;
import br.ufjf.pgcc.eseco.app.service.BioCatalogueService;
import br.ufjf.pgcc.eseco.domain.model.context.WorkflowServiceContextModel;
import br.ufjf.pgcc.eseco.domain.model.resource.Component;
import br.ufjf.pgcc.eseco.domain.model.analysis.ServiceDependency;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowService;
import br.ufjf.pgcc.eseco.domain.service.component.ComponentService;
import br.ufjf.pgcc.eseco.domain.service.component.ServiceWorkflowService;
import br.ufjf.pgcc.eseco.domain.service.context.WorkflowServiceContextModelService;
import com.google.gson.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
public class ComponentsController {

    private static final int DETAIL_PLUGIN = 1;
    private static final int DETAIL_WORKFLOW_SERVICE_INTERNAL = 2;
    private static final int DETAIL_WORKFLOW_SERVICE_EXTERNAL_BIOCATALOGUE = 3;

    private ComponentService componentService;
    private ServiceWorkflowService serviceWorkflowService;
    private BioCatalogueService bioCatalogueService;
    private WorkflowServiceContextModelService workflowServiceContextModelService;

    @Autowired
    public ComponentsController(ComponentService componentService, ServiceWorkflowService serviceWorkflowService,
                                BioCatalogueService bioCatalogueService,
                                WorkflowServiceContextModelService workflowServiceContextModelService) {
        this.componentService = componentService;
        this.serviceWorkflowService = serviceWorkflowService;
        this.bioCatalogueService = bioCatalogueService;
        this.workflowServiceContextModelService = workflowServiceContextModelService;
    }

    @RequestMapping(value = "/components")
    public String overview() {
        return "components/overview";
    }


    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // COMPONENTS DETAILS                                                                                            //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    @RequestMapping(value = "/components/details/{type}/{id}")
    public String serviceDetails(Model model,
                                 @PathVariable(value = "type") int type,
                                 @PathVariable(value = "id") int id) throws ClassNotFoundException {

        model.addAttribute("type", type);

        switch (type) {
            case DETAIL_PLUGIN:
            case DETAIL_WORKFLOW_SERVICE_INTERNAL:
                Component component = componentService.find(id);
                if (null != component) {
                    // Create context info for this component
                    WorkflowServiceContextModel componentContextInfo = null;
                    try {
                        componentContextInfo = workflowServiceContextModelService.createModelInfo(component);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    model.addAttribute("component", component);
                    model.addAttribute("componentContextInfo", componentContextInfo);
                }
                break;

            case DETAIL_WORKFLOW_SERVICE_EXTERNAL_BIOCATALOGUE:
                // @TODO: BIOCATALOGUE: get result from biocatalogue service getDetails
                break;
        }

        return "components/details";
    }


    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // COMPONENTS EXPLORERS                                                                                          //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    @RequestMapping(value = "/components/plugins")
    public String plugins() {
        return "components/explore-plugins";
    }

    @RequestMapping(value = "/components/workflow-services/internal")
    public String workflowServicesInternal(Model model) {

        List<WorkflowService> services_workflow_list = serviceWorkflowService.findAll();

        model.addAttribute("services_workflow_list", services_workflow_list);

        return "components/explore-workflow-services-internal";
    }

    @RequestMapping(value = "/components/workflow-services/external")
    public String workflowServicesExternal() {
        return "components/explore-workflow-services-external";
    }

    @RequestMapping(value = "/components/workflow-services/search", method = RequestMethod.POST)
    public String workflowServicesSearch(Model model, HttpServletRequest request) {

        String searchQuery = request.getParameter("search_string");

        ArrayList<WorkflowServiceSearchResult> searchResults = null;

        // Search in BioCatalogue
        try {
            searchResults = bioCatalogueService.search(searchQuery, "services");

        } catch (BioCatalogueException e) {
            e.printStackTrace();
        }

        model.addAttribute("searchString", searchQuery);
        model.addAttribute("searchResults", searchResults);

        return "components/explore-workflow-services-external";
    }


    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // COMPONENTS COMPOSITIONS                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    @RequestMapping(value = "/components/compositions/workflow-services")
    public String compositionsWorkflowServices() {
        return "components/compositions-workflow-services";
    }


    @RequestMapping(value = "/returnjson", method = RequestMethod.GET)
    @ResponseBody
    public String returnJson() {

        ServiceDependency sd = new ServiceDependency();
        sd.setName("WsUserList");

        ServiceDependency sd2 = new ServiceDependency();
        sd2.setName("br.ufjf.pgcc.eseco.dao.AgentDAO");

        ServiceDependency sd3 = new ServiceDependency();
        sd3.setName("br.ufjf.pgcc.eseco.model.Agent");
        sd3.setSize(5);

        sd2.addChild(sd3);
        sd.addChild(sd2);

        Gson gson = new GsonBuilder().create();

        return gson.toJson(sd);
    }
}