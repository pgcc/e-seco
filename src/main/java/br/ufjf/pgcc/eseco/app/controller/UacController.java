package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.common.controller.CommonController;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.uac.UserService;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class UacController extends CommonController {

    @Autowired
    private JavaMailSender mailSender;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login() {
        return "uac/login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(User user, HttpSession session, Model model) {
        UserService userService = getService(UserService.class);

        User authenticatedUser = userService.findByEmailAndPassword(user.getLogin(), user.getPassword());

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

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String register() {
        return "uac/register";
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String register(User user, Model model) {

        UserService userService = getService(UserService.class);

        ///////////////////////////////////////////////////////////////////////
        // VALIDATE DATA                                                     //
        ///////////////////////////////////////////////////////////////////////
        ArrayList<String> errorsList = new ArrayList<String>();

        // Name
        if(user.getName().equals("")){
            errorsList.add("Name cannot be empty.");
        }

        // E-mail
        if(user.getEmail().equals("")){
            errorsList.add("E-mail cannot be empty.");
        }else{
            List<User> usersWithSameEmail = userService.findByEmail(user.getEmail());
            if(!usersWithSameEmail.isEmpty()){
                errorsList.add("The provided E-mail is already registered to another user.");
            }
        }


        ///////////////////////////////////////////////////////////////////////
        // PROCESS VALIDATED DATA                                            //
        ///////////////////////////////////////////////////////////////////////
        if(errorsList.isEmpty()){
            try {
                user = userService.registerNewUser(user);

                MimeMessage mimeMessage = mailSender.createMimeMessage();
                MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, false, "utf-8");

                String authentication_code = DigestUtils.sha1Hex("ae");
                String authentication_uri = "/register/" + authentication_code;
                String to = user.getEmail();
                String subject = "New Account Registration";
                String content = "" +
                        "<p>Hi <strong>" + user.getName() + "</strong>!</p>" +
                        "<br>" +
                        "<p>Welcome to E-seco. In order to validate your new account, please, follow the link below:</p>" +
                        "<br>" +
                        "<br>" +
                        "<a href='" + authentication_uri + "'>" + authentication_uri + "</a>" +
                        "<br>"+
                        "<br>"+
                        "<p>E-Seco</p>";

                mimeMessage.setContent(content, "text/html");
                helper.setTo(to);
                helper.setSubject(subject);
                helper.setFrom("E-Seco<eseco@datawebhost.com.br>");

                mailSender.send(mimeMessage);

                model.addAttribute("new_user", user);

                return "uac/register-phase-one-result";

            } catch (MessagingException e) {
                errorsList.add(e.getMessage());
            }
        }


        ///////////////////////////////////////////////////////////////////////
        // ERROR HANDLING                                                    //
        ///////////////////////////////////////////////////////////////////////
        if(!errorsList.isEmpty()){
            model.addAttribute("error", true);
            model.addAttribute("error_messages", errorsList);
        }

        return "uac/register";
    }

    @RequestMapping(value = "/profile")
    public String profile() {
        return "uac/profile";
    }
}
