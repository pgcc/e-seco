package br.ufjf.pgcc.eseco.app.config;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.annotation.*;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import java.io.IOException;
import java.util.Properties;

@Configuration
public class SpringMailConfig implements ApplicationContextAware {

    private static final String MAIL_CONFIG_FILE = "classpath:config.mail.properties";
    private static final String JAVA_MAIL_CONFIG_FILE = "classpath:config.mail.javamail.properties";

    private ApplicationContext applicationContext;


    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.applicationContext = applicationContext;
    }

    @Bean
    public JavaMailSender mailSender() throws IOException {

        final JavaMailSenderImpl mailSender = new JavaMailSenderImpl();

        // Basic mail sender configuration, based on config.mail.properties
        final Properties mailProperties = new Properties();
        mailProperties.load(this.applicationContext.getResource(MAIL_CONFIG_FILE).getInputStream());
        mailSender.setUsername(mailProperties.getProperty("mail.server.username"));
        mailSender.setPassword(mailProperties.getProperty("mail.server.password"));

        // JavaMail-specific mail sender configuration, based on config.mail.javamail.properties
        final Properties javaMailProperties = new Properties();
        javaMailProperties.load(this.applicationContext.getResource(JAVA_MAIL_CONFIG_FILE).getInputStream());
        mailSender.setJavaMailProperties(javaMailProperties);

        return mailSender;
    }
}