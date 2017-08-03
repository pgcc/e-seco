package br.ufjf.pgcc.eseco.common.controller;

import br.ufjf.pgcc.eseco.app.config.AppConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;

public abstract class CommonController {
/*
    @Autowired
    protected WebApplicationContext context;
*/
    /**
     * Get a Service from context.
     *
     * @param serviceClass The service class to be instantiated
     * @param <T>          The service class type that will be returned
     *
     * @return The instantiated service class
     */
    /*
    protected <T> T getService(Class<T> serviceClass) {

        //AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext(AppConfig.class);
        //return context.getBean(serviceClass);


        return context.getBean(serviceClass);
    }
    */
}
