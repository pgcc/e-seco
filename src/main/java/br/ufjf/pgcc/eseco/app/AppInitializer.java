package br.ufjf.pgcc.eseco.app;

import br.ufjf.pgcc.eseco.app.config.AppConfig;
import br.ufjf.pgcc.eseco.app.config.DispatcherConfig;

import br.ufjf.pgcc.eseco.app.config.SpringMailConfig;
import br.ufjf.pgcc.eseco.app.config.WebConfig;
import java.io.File;
import javax.servlet.MultipartConfigElement;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

import javax.servlet.ServletContext;
import javax.servlet.ServletRegistration;

public class AppInitializer implements WebApplicationInitializer {

    private int maxUploadSizeInMb = 5 * 1024 * 1024; // 5 MB
    
    @Override
    public void onStartup(ServletContext container) {
        // Create the 'root' Spring application context
        AnnotationConfigWebApplicationContext rootContext = new AnnotationConfigWebApplicationContext();
        rootContext.register(AppConfig.class);
        rootContext.register(SpringMailConfig.class);

        // Manage the lifecycle of the root application context
        container.addListener(new ContextLoaderListener(rootContext));

        // Create the dispatcher servlet's Spring application context
        AnnotationConfigWebApplicationContext dispatcherContext
                = new AnnotationConfigWebApplicationContext();
        dispatcherContext.register(DispatcherConfig.class);
        dispatcherContext.register(WebConfig.class);

        // Register and map the dispatcher servlet
        ServletRegistration.Dynamic dispatcher
                = container.addServlet("dispatcher", new DispatcherServlet(dispatcherContext));
        dispatcher.setLoadOnStartup(1);
        dispatcher.addMapping("/");
        
        // temp file will be uploaded here
        File uploadDirectory = new File(System.getProperty("java.io.tmpdir"));

        // register a MultipartConfigElement
        MultipartConfigElement multipartConfigElement =
                new MultipartConfigElement(uploadDirectory.getAbsolutePath(),
                        maxUploadSizeInMb, maxUploadSizeInMb * 2, maxUploadSizeInMb / 2);

        dispatcher.setMultipartConfig(multipartConfigElement);
    }
}
