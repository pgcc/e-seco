package br.ufjf.pgcc.eseco.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ExperimentsController {

    @RequestMapping(value = "/experiments")
    public String overview() {
        return "experiments/overview";
    }
}



