package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.domain.model.misc.Notification;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;

@Controller
public class NotificationsController {

    @RequestMapping(value = "/notifications")
    public String notifications(Model model, HttpSession session) {

        // Split important notifications from common notifications
        ArrayList<Notification> importantNotificationsList = new ArrayList<>();
        ArrayList<Notification> commonNotificationsList = new ArrayList<>();
        ArrayList<Notification> notificationsList = (ArrayList<Notification>) session.getAttribute("notifications");

        for (Notification notification : notificationsList) {
            if (notification.isImportant()) {
                importantNotificationsList.add(notification);
            } else {
                commonNotificationsList.add(notification);
            }
        }

        model.addAttribute("importantNotifications", importantNotificationsList);
        model.addAttribute("commonNotifications", commonNotificationsList);

        return "notifications/overview";
    }
}



