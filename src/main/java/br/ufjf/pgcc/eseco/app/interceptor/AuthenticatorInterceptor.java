package br.ufjf.pgcc.eseco.app.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AuthenticatorInterceptor implements HandlerInterceptor {

    /**
     * @param httpServletRequest HTTP Request object to be pre handled.
     * @param httpServletResponse HTTP Response object to be pre handled.
     * @param handler Object target of handle.
     *
     * @return boolean
     *
     * @throws Exception Simple Exception
     */
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse,
            Object handler) throws Exception {

        // Get requested URI
        String uri = httpServletRequest.getRequestURI();
        String contextPath = httpServletRequest.getContextPath();

        // Get the requested Route
        String[] uriParts = uri.split("/");
        String route = "home";
        if (uriParts.length >= 3) {
            route = uriParts[2];
        }

        // Get user logged status
        Object userIsLogged = httpServletRequest.getSession().getAttribute("logged_user");

        // Get roles
        Boolean roleAdmin = (Boolean) httpServletRequest.getSession().getAttribute("role_admin");
        Boolean roleResearcher = (Boolean) httpServletRequest.getSession().getAttribute("role_researcher");
        Boolean roleDeveloper = (Boolean) httpServletRequest.getSession().getAttribute("role_developer");

        // Authorize Resources for all
        if (route.equals("resources")) {
            return true;
        }

        //////////////////////////////////////////////////////////////////////
        // AUTHORIZATION FOR NON LOGGED USERS                               //
        //////////////////////////////////////////////////////////////////////
        if (userIsLogged == null) {
            if (route.equals("login") || route.equals("register") || route.equals("recovery") || route.equals("api")) {
                return true;
            } else {
                httpServletResponse.sendRedirect(contextPath+"/login");
                return false;
            }
        }

        //////////////////////////////////////////////////////////////////////
        // AUTHORIZATION FOR LOGGED USERS                                   //
        //////////////////////////////////////////////////////////////////////
        // Block logged users from acessing login, register and recovery
        if (route.equals("login") || route.equals("register") || route.equals("recovery")) {
            httpServletResponse.sendRedirect(contextPath);
            return false;
        }

        // Authorize logged users to access paths accordingly with his roles
        Boolean isAuthorized = false;

        // Admins
        if (roleAdmin) {
            // Admin may access all resources
            isAuthorized = true;
        }

        // Researchers
        if (roleResearcher) {
            switch (route) {
                case "api":
                case "plugins":
                case "not-authorized":
                case "logout":
                case "home":
                case "notifications":
                case "profile":
                case "members":
                case "components":
                case "experiments":
                case "experimentPhaseReport":
                case "researchers":
                case "agents":
                case "disciplines":
                case "institutions":
                case "researchGroups":
                case "support":
                case "ontology":
                    isAuthorized = true;
                    break;
            }
        }

        // Developers
        if (roleDeveloper) {
            switch (route) {
                case "api":
                case "plugins":
                case "not-authorized":
                case "logout":
                case "home":
                case "notifications":
                case "profile":
                case "members":
                case "components":
                case "experiments":
                case "developers":
                case "agents":
                case "disciplines":
                case "institutions":
                case "researchGroups":
                case "support":
                case "ontology":
                    isAuthorized = true;
                    break;
            }
        }

        // Check if user is authorized
        if (isAuthorized) {
            return true;
        } else {
            httpServletResponse.sendRedirect(contextPath+"/not-authorized");
            return false;
        }
    }

    /**
     * @param httpServletRequest HTTP Request object to be pre handled.
     * @param httpServletResponse HTTP Response object to be pre handled.
     * @param handler Object target of handle.
     * @param modelAndView modelAndView
     *
     * @throws Exception Simple Exception
     */
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse,
            Object handler, ModelAndView modelAndView) throws Exception {

    }

    /**
     * @param httpServletRequest HTTP Request object to be pre handled.
     * @param httpServletResponse HTTP Response object to be pre handled.
     * @param handler Object target of handle.
     * @param e Simple Exception
     *
     * @throws Exception Simple Exception
     */
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse,
            Object handler, Exception e) throws Exception {

    }
}
