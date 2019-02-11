package br.ufjf.pgcc.eseco.app.plugins.CollaborativeResearchEnvironment.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
public class CREController {

    @RequestMapping(value = "/plugins/cre")
    public String home(Model model, HttpSession session) {



        return "plugins/cre/home";
    }
}
