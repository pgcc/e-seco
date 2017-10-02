package br.ufjf.pgcc.eseco.app.config;

import br.ufjf.pgcc.eseco.app.interceptor.AuthenticatorInterceptor;
import br.ufjf.pgcc.eseco.app.interceptor.NotificationsInterceptor;
import br.ufjf.pgcc.eseco.app.converter.DisciplineIdToDisciplineConverter;
import br.ufjf.pgcc.eseco.app.converter.InstitutionIdToInstitutionConverter;
import br.ufjf.pgcc.eseco.app.converter.ResearchGroupIdToResearchGroupConverter;
import br.ufjf.pgcc.eseco.app.converter.ResearcherIdToResearcherConverter;
import br.ufjf.pgcc.eseco.app.converter.WorkflowIdToWorkflowConverter;
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

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(authenticatorInterceptor());
        registry.addInterceptor(notificationsInterceptor());
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
        registry.addConverter(new DisciplineIdToDisciplineConverter());
        registry.addConverter(new InstitutionIdToInstitutionConverter());
        registry.addConverter(new ResearchGroupIdToResearchGroupConverter());
        registry.addConverter(new ResearcherIdToResearcherConverter());
        registry.addConverter(new WorkflowIdToWorkflowConverter());
    }

}
