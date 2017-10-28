package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.model.Notification;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;

@Controller
public class MainController {

    @RequestMapping(value = "/")
    public String home(Model model, HttpSession session) {

        // Get important notifications to show
        ArrayList<Notification> importantNotificationsList = new ArrayList<>();
        ArrayList<Notification> notificationsList = (ArrayList<Notification>) session.getAttribute("notifications");
        for (Notification notification : notificationsList) {
            if (notification.isImportant()) {
                importantNotificationsList.add(notification);
            }
        }

        model.addAttribute("notifications", importantNotificationsList);

        return "home";
    }
}



