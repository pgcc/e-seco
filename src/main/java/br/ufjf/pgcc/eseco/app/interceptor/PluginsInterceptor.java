package br.ufjf.pgcc.eseco.app.interceptor;

import br.ufjf.pgcc.eseco.app.model.plugins.PluginFeatures;
import br.ufjf.pgcc.eseco.app.model.plugins.PluginInterface;
import br.ufjf.pgcc.eseco.app.model.plugins.PluginMenuEntryFeatureInterface;
import br.ufjf.pgcc.eseco.domain.model.resource.Plugin;
import br.ufjf.pgcc.eseco.domain.service.resource.PluginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Constructor;
import java.util.ArrayList;
import java.util.List;

public class PluginsInterceptor implements HandlerInterceptor {

    @Autowired
    private PluginService pluginService;

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

        // Init Plugins List
        ArrayList<PluginInterface> pluginsList = new ArrayList<>();
        ArrayList<PluginMenuEntryFeatureInterface> pluginsMenyEntryFeatureList = new ArrayList<>();

        try {
            List<Plugin> plugins = pluginService.findAll();

            for (Plugin plugin : plugins) {
                Class internalClass = Class.forName(plugin.getInternalClass());

                PluginInterface newPlugin = (PluginInterface) internalClass.newInstance();

                for (PluginFeatures feature : newPlugin.getFeatures()) {
                    switch (feature) {
                        case MENU_ENTRY:
                            pluginsMenyEntryFeatureList.add(newPlugin.getMenuEntryFeature());
                            break;

                        case BACKGROUND_TASK:
                            break;

                        case CONTROLLER:
                            break;
                    }
                }

                pluginsList.add(newPlugin);
            }

        } catch (Exception ex) {
            System.out.println(ex);
            return true;
        }

        //////////////////////////////////////////////////////////////////////
        // SESSION POPULATE                                                 //
        //////////////////////////////////////////////////////////////////////
        // Set the Plugins List on Session
        session.setAttribute("eseco_plugins", pluginsList);
        session.setAttribute("eseco_plugins_menu_entries", pluginsMenyEntryFeatureList);

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
