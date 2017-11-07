package br.ufjf.pgcc.eseco.services.sample;

import br.ufjf.pgcc.eseco.domain.annotation.ComposedOf;
import br.ufjf.pgcc.eseco.domain.annotation.EsecoWorkflowService;
import br.ufjf.pgcc.eseco.domain.service.uac.UserService;

@EsecoWorkflowService
@ComposedOf(servicesClasses = {UserService.class})
public class Service02 {

    private String somedata;

    public String methodForSomething(){
        return "return something";
    }
}
