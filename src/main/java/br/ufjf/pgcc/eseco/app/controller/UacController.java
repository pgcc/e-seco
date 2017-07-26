package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.config.AppConfig;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.uac.UserService;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class UacController {

    private AnnotationConfigApplicationContext context;
    private UserService userService;

    public UacController(){
        this.context = new AnnotationConfigApplicationContext(AppConfig.class);
        this.userService = this.context.getBean(UserService.class);
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login() {
        return "uac/login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(User user, HttpSession session, Model model) {

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

    @RequestMapping(value = "/profile")
    public String profile(Model model) {

        // LISTAR USUARIOS
        List list_users = userService.findAll();

        //close resources
        context.close();

        model.addAttribute("users", list_users);

        return "uac/profile";
    }
}
