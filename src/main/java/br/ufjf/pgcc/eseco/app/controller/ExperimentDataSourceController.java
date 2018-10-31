package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.domain.model.experiment.*;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.experiment.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Logger;

@Controller
public class ExperimentDataSourceController {
    private static final Logger LOGGER = Logger.getLogger(ExperimentDataSourceController.class.getName());

    private DataProviderService dataProviderService;
    private DataSourceService dataSourceService;

    @Autowired
    public ExperimentDataSourceController(
            DataProviderService dataProviderService,
            DataSourceService dataSourceService) {
        this.dataProviderService = dataProviderService;
        this.dataSourceService = dataSourceService;
    }

    @RequestMapping(value = "/experiments/dataSources", method = RequestMethod.GET)
    public String ListDataSources(Model model, HttpSession session) {
        List<DataSource> dataSourceList = dataSourceService.findAll();

        model.addAttribute("dataSourceList", dataSourceList);

        return "experiments/dataSources/list";
    }

    @RequestMapping(value = "/experiments/dataSources/{id}", method = RequestMethod.GET)
    public String viewDataSource(@PathVariable("id") int id, Model model) {
        DataSource dataSource = dataSourceService.find(id);

        model.addAttribute("dataSource", dataSource);

        return "experiments/dataSources/view";
    }

    @RequestMapping(value = "/experiments/dataSources/add", method = RequestMethod.GET)
    public String addDataSource(Model model) {
        // Get data providers list
        List<DataProvider> dataProvidersList = dataProviderService.findAll();
        model.addAttribute("dataProvidersList", dataProvidersList);

        return "experiments/dataSources/add";
    }

    @RequestMapping(value = "/experiments/dataSources/add", method = RequestMethod.POST)
    public String addDataSourcePost(Model model, HttpServletRequest request) {
        // Set return view
        String returnView = "experiments/dataSources/add";

        // Get data providers list
        List<DataProvider> dataProvidersList = dataProviderService.findAll();
        model.addAttribute("dataProvidersList", dataProvidersList);


        /* ********************************************************************************************************** */
        /* GET FORM DATA                                                                                              */
        /* ********************************************************************************************************** */
        // Name
        String name = request.getParameter("datasource-name");

        // Data Providers
        List<DataSourceProvider> chosenDataSourceProvidersList = new ArrayList<>();
        for (DataProvider dataProvider : dataProvidersList) {
            if (null != request.getParameter("datasource-dataprovider-" + String.valueOf(dataProvider.getId()))) {

                DataSourceProvider newDataSourceProvider = new DataSourceProvider();
                newDataSourceProvider.setDataProvider(dataProvider);

                // Get Data Providers Informed Parameters
                List<DataSourceProviderParameter> dataSourceProviderParameterList = new ArrayList<>();
                for (DataProviderParameter dataProviderParameter : dataProvider.getParameters()) {
                    String dpParameter = request.getParameter("dp-parameter-" + String.valueOf(dataProviderParameter.getId()));
                    if (null != dpParameter) {
                        DataSourceProviderParameter newDataSourceProviderParameter = new DataSourceProviderParameter();
                        newDataSourceProviderParameter.setDataProviderParameter(dataProviderParameter);
                        newDataSourceProviderParameter.setValueString(dpParameter);

                        dataSourceProviderParameterList.add(newDataSourceProviderParameter);
                    }
                }
                newDataSourceProvider.setParameters(dataSourceProviderParameterList);

                chosenDataSourceProvidersList.add(newDataSourceProvider);
            }
        }

        for(DataSourceProvider dataSourceProvider : chosenDataSourceProvidersList){
            System.out.print("DataProvider: ");
            System.out.print(dataSourceProvider.getDataProvider().getName());
            System.out.print(" :: id: ");
            System.out.println(dataSourceProvider.getDataProvider().getId());
            System.out.println("Parameters: ");
            for(DataSourceProviderParameter dataSourceProviderParameter: dataSourceProvider.getParameters()){
                System.out.print(dataSourceProviderParameter.getDataProviderParameter().getName());
                System.out.print(" = ");
                System.out.println(dataSourceProviderParameter.getValueString());
            }
            System.out.println("-----------");
        }

        /* ********************************************************************************************************** */
        /* VALIDATE FORM DATA                                                                                         */
        /* ********************************************************************************************************** */
        // Name
        if (null == name) {
            model.addAttribute("errorNameRequired", true);
            return returnView;
        }

        // Data Providers
        if (chosenDataSourceProvidersList.isEmpty()) {
            model.addAttribute("errorDataProviderRequired", true);
            return returnView;
        }


        /* ********************************************************************************************************** */
        /* PROCESS FORM DATA                                                                                          */
        /* ********************************************************************************************************** */
        // Get Session
        HttpSession session = request.getSession();

        // Get Logged User from Session
        User user = (User) session.getAttribute("logged_user");

        // Create the new Data Source
        DataSource newDataSource = new DataSource();
        newDataSource.setName(name);
        newDataSource.setAuthor(user.getAgent().getResearcher());
        newDataSource.setDateCreated(new Date());
        newDataSource.setProviders(chosenDataSourceProvidersList);

        // Persist the new Data Source on database
        try {
            dataSourceService.add(newDataSource);
        } catch (Exception e) {
            model.addAttribute("errorDataBase", true);
            return returnView;
        }

        // Return the success message
        model.addAttribute("success", true);
        return returnView;
    }

    @RequestMapping(value = "/experiments/dataSources/{id}/update", method = RequestMethod.GET)
    public String updateDataSource(@PathVariable("id") int id, Model model) {
        return "experiments/dataSources/update";
    }

    @RequestMapping(value = "/experiments/dataSources/{id}/update", method = RequestMethod.POST)
    public String updateDataSourcePost(@PathVariable("id") int id, Model model, HttpServletRequest request) {
        // @TODO: Soon
        return "experiments/dataSources/update";
    }
}
