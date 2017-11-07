package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.domain.service.core.AgentService;
import br.ufjf.pgcc.eseco.common.controller.CommonController;
import br.ufjf.pgcc.eseco.domain.model.core.Agent;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@SessionAttributes({"agentForm"})
public class AgentsController extends CommonController {

    private static final Logger LOGGER = Logger.getLogger(AgentsController.class.getName());

    private final AgentService agentService;

    @Autowired
    public AgentsController(AgentService agentService) {
        this.agentService = agentService;
    }
    
    @RequestMapping(value = "/agents", method = RequestMethod.GET)
    public String showAllAgents(Model model) {

        LOGGER.info("showAllAgents()");
        model.addAttribute("agents", agentService.findAll());
        
        return "agents/list";
    }
    

    @RequestMapping(value = "/agents/add", method = RequestMethod.GET)
    public String showAddAgentForm(Model model, HttpSession session) {

        LOGGER.info("showAddAgentForm()");

        return "agents/agent-form";
    }

    @RequestMapping(value = "/agents/{id}", method = RequestMethod.GET)
    public String showAgent(@PathVariable("id") int id, Model model, HttpSession session) {

        LOGGER.log(Level.INFO, "showAgent() : {0}", id);

        Agent agent = agentService.find(id);

        if (agent == null) {
            model.addAttribute("css", "danger");
            model.addAttribute("msg", "Agent not found");

            model.addAttribute("agentForm", agent);
            return "agents/agent-form";
        }
        model.addAttribute("agent", agent);
        return "agents/show";

    }

    @RequestMapping(value = "/agents/{id}/update", method = RequestMethod.GET)
    public String showUpdateAgentForm(@PathVariable("id") int id, Model model) {

        LOGGER.log(Level.INFO, "showUpdateAgentForm() : {0}", id);

        Agent agent = agentService.find(id);
        model.addAttribute("agentForm", agent);
        return "agents/agent-form";

    }

    @RequestMapping(value = "/agents", method = RequestMethod.POST)
    public String saveOrUpdateAgent(@ModelAttribute("agentForm") Agent agent, HttpSession session,
            Model model) {

        LOGGER.log(Level.INFO, "saveOrUpdateAgent() : {0}", agent);

        try {
            agent = agentService.updateAgent(agent);
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, null, ex);
        }

        return "redirect:/agents/" + agent.getId();

    }
}
