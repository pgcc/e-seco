package br.ufjf.pgcc.eseco.app.interceptor;

import br.ufjf.pgcc.eseco.domain.model.core.Agent;
import br.ufjf.pgcc.eseco.app.model.Notification;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowServiceRatingInvitation;
import br.ufjf.pgcc.eseco.domain.model.uac.User;
import br.ufjf.pgcc.eseco.domain.service.resource.WorkflowServiceRatingInvitationService;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

public class NotificationsInterceptor implements HandlerInterceptor {

    /**
     * @param httpServletRequest  HTTP Request object to be pre handled.
     * @param httpServletResponse HTTP Response object to be pre handled.
     * @param handler             Object target of handle.
     *
     * @return boolean
     *
     * @throws Exception Simple Exception
     */
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse,
                             Object handler) throws Exception {

        // Get Session
        HttpSession session = httpServletRequest.getSession();

        // Get Logged User from Session
        User user = (User) session.getAttribute("logged_user");

        // If There's no user logged, don't do futher processings
        if (user == null) {
            return true;
        }

        // Init Notifications List
        ArrayList<Notification> notificationsList = new ArrayList<>();

        // Get User Agent
        Agent agent = user.getAgent();


        //////////////////////////////////////////////////////////////////////
        // PROFILES NOTIFICATIONS                                           //
        //////////////////////////////////////////////////////////////////////

        // User with Researcher Role but without the Researcher Profile
        if ((Boolean) session.getAttribute("role_researcher")) {
            if (agent.getResearcher() == null) {
                Notification notification = new Notification();
                notification.setText("You don't have a Researcher Profile Yet! Create one Right Now!");
                notification.setLink("/researchers/add");
                notification.setIcon("fa-id-card-o");
                notification.setImportant(true);
                notificationsList.add(notification);
            }
        }

        // User with Developer Role but without the Developer Profile
        if ((Boolean) session.getAttribute("role_developer")) {
            if (agent.getDeveloper() == null) {
                Notification notification = new Notification();
                notification.setText("You don't have a Developer Profile Yet! Create one Right Now!");
                notification.setLink("/developers");
                notification.setIcon("fa-id-card-o");
                notification.setImportant(true);
                notificationsList.add(notification);
            }
        }


        //////////////////////////////////////////////////////////////////////
        // UNCOMPLETED COMPONENT RATINGS NOTIFICATIONS                      //
        //////////////////////////////////////////////////////////////////////

        if(null != agent.getResearcher()) {
            List<WorkflowServiceRatingInvitation> workflowServiceRatingInvitationList = agent.getResearcher().getWorkflowServiceRatingInvitations();
            int openInvitationsCount = 0;
            for (WorkflowServiceRatingInvitation wfri : workflowServiceRatingInvitationList) {
                if (!wfri.isCompleted()) {
                    openInvitationsCount++;
                }
            }

            if (openInvitationsCount > 0) {
                Notification notification = new Notification();
                notification.setText("You have Invitations for Rating on one or more Workflow Services Components");
                notification.setLink("/components/actions/workflow-services/rating");
                notification.setIcon("fa-id-card-o");
                notification.setImportant(true);
                notificationsList.add(notification);
            }
        }


        //////////////////////////////////////////////////////////////////////
        // SESSION POPULATE                                                 //
        //////////////////////////////////////////////////////////////////////

        // Set the Notifications List on Session
        session.setAttribute("notifications", notificationsList);

        return true;
    }

    /**
     * @param httpServletRequest  HTTP Request object to be pre handled.
     * @param httpServletResponse HTTP Response object to be pre handled.
     * @param handler             Object target of handle.
     * @param modelAndView        modelAndView
     *
     * @throws Exception Simple Exception
     */
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse,
                           Object handler, ModelAndView modelAndView) throws Exception {

    }

    /**
     * @param httpServletRequest  HTTP Request object to be pre handled.
     * @param httpServletResponse HTTP Response object to be pre handled.
     * @param handler             Object target of handle.
     * @param e                   Simple Exception
     *
     * @throws Exception Simple Exception
     */
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse,
                                Object handler, Exception e) throws Exception {

    }
}
