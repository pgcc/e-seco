package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.domain.model.experiment.DataSource;
import br.ufjf.pgcc.eseco.domain.model.experiment.DetailGroup;
import br.ufjf.pgcc.eseco.domain.model.experiment.Entity;
import br.ufjf.pgcc.eseco.domain.model.experiment.SourceName;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

@Controller
@SessionAttributes({"dataSourceForm"})
public class ExperimentDataSourceController {
    private static final Logger LOGGER = Logger.getLogger(ExperimentDataSourceController.class.getName());

    @Autowired
    public ExperimentDataSourceController() {
    }

    @RequestMapping(value = "/experiments/dataSources", method = RequestMethod.GET)
    public String showAllDataSources(Model model, HttpSession session) {

        LOGGER.info("showAllDataSources()");

        ArrayList<DataSource> myDataSources = new ArrayList<>();
        ArrayList<DataSource> dataSources = new ArrayList<>();
        model.addAttribute("myDataSources", myDataSources);
        model.addAttribute("dataSources", dataSources);

        //return "experiments/dataSources/list";
        return "experiments/dataSources/show";
    }

    @RequestMapping(value = "/experiments/dataSources/add", method = RequestMethod.GET)
    public String showAddDataSourceForm(Model model, HttpSession session) {

        LOGGER.info("showAddDataSourceForm()");

        User user = (User) session.getAttribute("logged_user");

        DataSource dataSource = new DataSource();
        dataSource.setAuthor(user.getAgent().getResearcher());
        model.addAttribute("dataSourceForm", dataSource);
        model.addAttribute("sourceNameList", SourceName.getList());
        return "experiments/dataSources/dataSources-form";
    }

    @RequestMapping(value = "/experiments/dataSources/{id}/update", method = RequestMethod.GET)
    public String showUpdateEntityForm(@PathVariable("id") int id, Model model) {

        LOGGER.log(Level.INFO, "showUpdateDataSourceForm() : {0}", id);
        return "experiments/dataSources/dataSources-form";
    }

    /*@RequestMapping(value = "/experiments/dataSources", method = RequestMethod.GET)
    public String showDataSource(Model model, HttpSession session){
        DataSource dataSource = new DataSource();
        model.addAttribute("dataSource", dataSource);
        return "/experiments/dataSources/show";
    }*/


}
