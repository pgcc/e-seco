package br.ufjf.pgcc.eseco.common.controller;

import br.ufjf.pgcc.eseco.app.config.AppConfig;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public abstract class CommonController {

    /**
     * Get a Service from context.
     *
     * @param serviceClass The service class to be instantiated
     * @param <T>          The service class type that will be returned
     *
     * @return The instantiated service class
     */
    protected static <T> T getService(Class<T> serviceClass) {
        AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext(AppConfig.class);
        return context.getBean(serviceClass);
    }
}
