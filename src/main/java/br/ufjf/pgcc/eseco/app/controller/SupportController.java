package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.common.controller.CommonController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SupportController extends CommonController {

    @Autowired
    public SupportController() {

    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // BASIC SUPPORT                                                                                                 //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    @RequestMapping(value = "/support")
    public String overview() {
        return "support/overview";
    }

    @RequestMapping(value = "/support/terms-of-use")
    public String termsOfUse() {
        return "support/terms-of-use";
    }

    @RequestMapping(value = "/support/privacy-policy")
    public String privacyPolicy() {
        return "support/privacy-policy";
    }



    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // SUPPORT FOR RESEARCHERS                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    @RequestMapping(value = "/support/researchers/first-steps")
    public String researchersFirstSteps() {
        return "support/researchers-first-steps";
    }



    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // SUPPORT FOR DEVELOPERS                                                                                        //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    @RequestMapping(value = "/support/developers/guidelines")
    public String DevelopersGuidelines() {
        return "support/developers-guidelines";
    }
}
