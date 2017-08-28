package br.ufjf.pgcc.eseco.app.config;

import br.ufjf.pgcc.eseco.app.interceptor.AuthenticatorInterceptor;
import br.ufjf.pgcc.eseco.app.interceptor.NotificationsInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
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

}
