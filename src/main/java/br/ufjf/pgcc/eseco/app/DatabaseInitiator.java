/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.app;

import br.ufjf.pgcc.eseco.domain.dao.core.CountryDAO;
import br.ufjf.pgcc.eseco.domain.dao.core.StateDAO;
import br.ufjf.pgcc.eseco.domain.service.core.CountryService;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 *
 * @author Lenita
 */
public class DatabaseInitiator implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {

        try {
            if (new CountryDAO().find(1) == null) {
                new CountryDAO().populateCountries();
            }
            if (new StateDAO().find(1) == null) {
                new StateDAO().populateBrazlStates();
            }
        } catch (Exception ex) {
            Logger.getLogger(AppInitializer.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

    }

}
