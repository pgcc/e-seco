package br.ufjf.pgcc.eseco.services.sample;

import br.ufjf.pgcc.eseco.domain.annotation.EsecoWorkflowService;

@EsecoWorkflowService
public class Service01 {

    private String attribute01;
    private String attribute02;
    private String attribute03;
    private String attribute04;
    private String attribute05;
    private String attribute06;
    private String attribute07;


    public String method01(){
        return "return some string";
    }

    public String method02(){
        return "return some string";
    }

    public String method03(){
        return "return some string";
    }

    public String method04(){
        return "return some string";
    }
}
