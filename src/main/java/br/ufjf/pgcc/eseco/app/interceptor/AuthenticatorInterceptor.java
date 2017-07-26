package br.ufjf.pgcc.eseco.app.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AuthenticatorInterceptor implements HandlerInterceptor {

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

        // Get requested URI
        String uri = httpServletRequest.getRequestURI();

        // Get user logged status
        Object userIsLogged = httpServletRequest.getSession().getAttribute("logged_user");

        // Authorize Resources for all
        if (uri.contains("resources")) {
            return true;
        }

        // Authorize Login for all not logged users
        if (uri.contains("login") && userIsLogged == null) {
            return true;
        }

        // Block logged users from acessing login
        if (uri.contains("login") && userIsLogged != null) {
            httpServletResponse.sendRedirect("/");
            return false;
        }

        // Authorize logged users to access any path
        if (userIsLogged != null) {
            return true;
        }

        // Block not logged users from acessing any other path
        httpServletResponse.sendRedirect("/login");
        return false;
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
