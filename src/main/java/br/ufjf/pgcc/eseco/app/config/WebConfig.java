package br.ufjf.pgcc.eseco.app.config;

import br.ufjf.pgcc.eseco.app.converter.ActivityExecutionIdToActivityExecutionConverter;
import br.ufjf.pgcc.eseco.app.converter.ActivityIdToActivityConverter;
import br.ufjf.pgcc.eseco.app.converter.DetailGroupIdToDetailGroupConverter;
import br.ufjf.pgcc.eseco.app.interceptor.AuthenticatorInterceptor;
import br.ufjf.pgcc.eseco.app.interceptor.NotificationsInterceptor;
import br.ufjf.pgcc.eseco.app.converter.DisciplineIdToDisciplineConverter;
import br.ufjf.pgcc.eseco.app.converter.ExperimentIdToExperientConverter;
import br.ufjf.pgcc.eseco.app.converter.InstitutionIdToInstitutionConverter;
import br.ufjf.pgcc.eseco.app.converter.InterestIdToInterestConverter;
import br.ufjf.pgcc.eseco.app.converter.PortIdToPortConverter;
import br.ufjf.pgcc.eseco.app.converter.ResearchGroupIdToResearchGroupConverter;
import br.ufjf.pgcc.eseco.app.converter.ResearcherIdToResearcherConverter;
import br.ufjf.pgcc.eseco.app.converter.StringToDateConverter;
import br.ufjf.pgcc.eseco.app.converter.WorkflowActivityIdToWorkflowActivityConverter;
import br.ufjf.pgcc.eseco.app.converter.WorkflowIdToWorkflowConverter;
import br.ufjf.pgcc.eseco.app.converter.WorkflowServiceIdToWorkflowServiceConverter;
import br.ufjf.pgcc.eseco.app.interceptor.PluginsInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.format.FormatterRegistry;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@EnableWebMvc
@Configuration
public class WebConfig extends WebMvcConfigurerAdapter {
    
    @Bean
    AuthenticatorInterceptor authenticatorInterceptor() {
        return new AuthenticatorInterceptor();
    }
    
    @Bean
    NotificationsInterceptor notificationsInterceptor() {
        return new NotificationsInterceptor();
    }

    @Bean
    PluginsInterceptor pluginsInterceptor() {
        return new PluginsInterceptor();
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(authenticatorInterceptor());
        registry.addInterceptor(notificationsInterceptor());
        registry.addInterceptor(pluginsInterceptor());
    }
    
    @Override
    public void addResourceHandlers(final ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
    }
    
    @Bean
    public ResourceBundleMessageSource messageSource() {
        ResourceBundleMessageSource rb = new ResourceBundleMessageSource();
        rb.setBasenames(new String[]{"messages/validation"});
        return rb;
    }
    
    @Override
    public void addFormatters(FormatterRegistry registry) {
        super.addFormatters(registry);
        registry.addConverter(new ActivityIdToActivityConverter());
        registry.addConverter(new DisciplineIdToDisciplineConverter());
        registry.addConverter(new InstitutionIdToInstitutionConverter());
        registry.addConverter(new ResearchGroupIdToResearchGroupConverter());
        registry.addConverter(new ResearcherIdToResearcherConverter());
        registry.addConverter(new WorkflowIdToWorkflowConverter());
        registry.addConverter(new WorkflowServiceIdToWorkflowServiceConverter());
        registry.addConverter(new StringToDateConverter());
        registry.addConverter(new InterestIdToInterestConverter());
        registry.addConverter(new ExperimentIdToExperientConverter());
        registry.addConverter(new PortIdToPortConverter());
        registry.addConverter(new ActivityExecutionIdToActivityExecutionConverter());
        registry.addConverter(new WorkflowActivityIdToWorkflowActivityConverter());
        registry.addConverter(new DetailGroupIdToDetailGroupConverter());
    }
    
}
