package br.ufjf.pgcc.eseco.services.sample;


public class Service03{

    public String composedMethod(){

        Service01 s1 = new Service01();
        Service01 s2 = new Service01();

        return "return something after a processing";
    }

}
