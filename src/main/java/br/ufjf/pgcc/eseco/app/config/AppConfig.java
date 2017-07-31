package br.ufjf.pgcc.eseco.app.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScans;
import org.springframework.context.annotation.Configuration;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalEntityManagerFactoryBean;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableTransactionManagement
@ComponentScans(value = {
    @ComponentScan("br.ufjf.pgcc.eseco.domain.dao"),
    @ComponentScan("br.ufjf.pgcc.eseco.domain.service"),
    @ComponentScan("br.ufjf.pgcc.eseco.app.service")
})
public class AppConfig {

    @Bean
    public LocalEntityManagerFactoryBean getEntityManagerFactoryBean() {
        LocalEntityManagerFactoryBean factoryBean = new LocalEntityManagerFactoryBean();
        factoryBean.setPersistenceUnitName("PERSISTENCE_LOCAL");
        return factoryBean;
    }

    @Bean
    public JpaTransactionManager getJpaTransactionManager() {
        JpaTransactionManager transactionManager = new JpaTransactionManager();
        transactionManager.setEntityManagerFactory(getEntityManagerFactoryBean().getObject());
        return transactionManager;
    }
}