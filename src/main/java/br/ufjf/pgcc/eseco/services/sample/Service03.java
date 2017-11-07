package br.ufjf.pgcc.eseco.services.sample;

import br.ufjf.pgcc.eseco.domain.annotation.ComposedOf;
import br.ufjf.pgcc.eseco.domain.annotation.EsecoWorkflowService;

@EsecoWorkflowService
@ComposedOf(servicesClasses = {Service01.class, Service02.class})
public class Service03{

    public String composedMethod(){

        Service01 s1 = new Service01();
        Service02 s2 = new Service02();

        return "return something after a processing";
    }

}
