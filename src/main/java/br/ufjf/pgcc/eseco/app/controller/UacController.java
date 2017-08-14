package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.common.controller.CommonController;
import br.ufjf.pgcc.eseco.domain.model.core.Developer;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.core.DeveloperService;
import br.ufjf.pgcc.eseco.domain.service.core.ResearcherService;
import br.ufjf.pgcc.eseco.domain.service.uac.UserService;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class UacController extends CommonController {

    private UserService userService;
    private DeveloperService developerService;

    @Autowired
    public UacController(UserService userService, DeveloperService developerService) {
        this.userService = userService;
        this.developerService = developerService;
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // LOGIN/LOGOUT                                                                                                  //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login() {
        return "uac/login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(User user, HttpSession session, Model model) {

        // Try to find a user with the passed login credentials
        User authenticatedUser = userService.findByEmailAndPassword(user.getLogin(), user.getPassword());

        // If a user can be found, register the session and redirect, otherwise, send an error to the view
        if (authenticatedUser != null) {
            session.setAttribute("logged_user", authenticatedUser);
            return "redirect:/";
        } else {
            model.addAttribute("error", true);
        }

        return "uac/login";
    }

    @RequestMapping(value = "/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:login";
    }


    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // REGISTER                                                                                                      //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String register() {
        return "uac/register";
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String register(User user, Model model) {

        ///////////////////////////////////////////////////////////////////////
        // VALIDATE DATA                                                     //
        ///////////////////////////////////////////////////////////////////////
        ArrayList<String> errorsList = new ArrayList<>();

        // Name
        if (user.getName().equals("")) {
            errorsList.add("Name cannot be empty.");
        }

        // E-mail
        if (user.getEmail().equals("")) {
            errorsList.add("E-mail cannot be empty.");
        } else {
            List<User> usersWithSameEmail = userService.findByEmail(user.getEmail());
            if (!usersWithSameEmail.isEmpty()) {
                errorsList.add("The provided E-mail is already registered to another user.");
            }
        }


        ///////////////////////////////////////////////////////////////////////
        // PROCESS VALIDATED DATA                                            //
        ///////////////////////////////////////////////////////////////////////
        if (errorsList.isEmpty()) {
            try {
                user = userService.registerNewUser(user);

                model.addAttribute("new_user", user);

                return "uac/register-phase-one-result";

            } catch (MessagingException e) {
                errorsList.add(e.getMessage());
            }
        }


        ///////////////////////////////////////////////////////////////////////
        // ERROR HANDLING                                                    //
        ///////////////////////////////////////////////////////////////////////
        if (!errorsList.isEmpty()) {
            model.addAttribute("error", true);
            model.addAttribute("error_messages", errorsList);
        }

        return "uac/register";
    }

    @RequestMapping(value = "/register/{activationCode}", method = RequestMethod.GET)
    public String registerActivation(Model model, @PathVariable(value = "activationCode") String activationCode) {

        // Try to find a user with the passed activation code
        User user = userService.findByActivationCode(activationCode);

        // If a user can be found, send him to view, otherwise, send an error to the view
        if (user != null) {
            model.addAttribute("user", user);
        } else {
            model.addAttribute("error_activation", true);
        }

        return "uac/register-activation";
    }

    @RequestMapping(value = "/register/{activationCode}", method = RequestMethod.POST)
    public String registerActivation(User user, Model model, @PathVariable(value = "activationCode") String activationCode) {

        // Redirect if the activation code don't return a valid user
        if (userService.findByActivationCode(activationCode) == null) {
            return "redirect:login";
        }

        ///////////////////////////////////////////////////////////////////////
        // VALIDATE DATA                                                     //
        ///////////////////////////////////////////////////////////////////////
        ArrayList<String> errorsList = new ArrayList<>();

        // Name
        if (user.getName().equals("")) {
            errorsList.add("Name cannot be empty.");
        }


        ///////////////////////////////////////////////////////////////////////
        // PROCESS VALIDATED DATA                                            //
        ///////////////////////////////////////////////////////////////////////
        if (errorsList.isEmpty()) {
            try {
                user = userService.registerNewUser(user);

                model.addAttribute("user", user);

                return "uac/register-phase-two-result";

            } catch (MessagingException e) {
                errorsList.add(e.getMessage());
            }
        }


        ///////////////////////////////////////////////////////////////////////
        // ERROR HANDLING                                                    //
        ///////////////////////////////////////////////////////////////////////
        if (!errorsList.isEmpty()) {
            model.addAttribute("error", true);
            model.addAttribute("error_messages", errorsList);
        }


        return "uac/register-activation";
    }


    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // MISCELLANEOUS                                                                                                 //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    @RequestMapping(value = "/profile")
    public String profile() {
        return "uac/profile";
    }
}
