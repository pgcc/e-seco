package br.ufjf.pgcc.eseco.app;

import br.ufjf.pgcc.eseco.domain.service.core.CountryService;
import br.ufjf.pgcc.eseco.domain.service.core.DisciplineService;
import br.ufjf.pgcc.eseco.domain.service.core.StateService;
import br.ufjf.pgcc.eseco.domain.service.uac.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

@Component
public class ApplicationStartup implements ApplicationListener<ContextRefreshedEvent> {

    @Autowired
    private CountryService countryService;

    @Autowired
    private StateService stateService;

    @Autowired
    private RoleService roleService;
    
    @Autowired
    private DisciplineService disciplineService;

    @Override
    public void onApplicationEvent(ContextRefreshedEvent e) {
        /*
        countryService.populateCountries();
        stateService.populateBrazilStates();
        disciplineService.populateDisiplines();
        roleService.populateRoles();
        */
    }
}
