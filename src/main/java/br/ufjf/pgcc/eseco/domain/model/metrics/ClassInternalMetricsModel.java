package br.ufjf.pgcc.eseco.domain.model.metrics;

public class ClassInternalMetricsModel {

    private String name;
    private int parametersCount;
    private int methodsCount;
    private int servicesCount;
    private int esecoCoreServicesCount;
    private int esecoWorkflowServicesCount;


    /* CONSTRUCTORS */

    public ClassInternalMetricsModel() {

    }


    /* GETTERS/SETTERS */

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getParametersCount() {
        return parametersCount;
    }

    public void setParametersCount(int parametersCount) {
        this.parametersCount = parametersCount;
    }

    public int getMethodsCount() {
        return methodsCount;
    }

    public void setMethodsCount(int methodsCount) {
        this.methodsCount = methodsCount;
    }

    public int getServicesCount() {
        return servicesCount;
    }

    public void setServicesCount(int servicesCount) {
        this.servicesCount = servicesCount;
    }

    public int getEsecoCoreServicesCount() {
        return esecoCoreServicesCount;
    }

    public void setEsecoCoreServicesCount(int esecoCoreServicesCount) {
        this.esecoCoreServicesCount = esecoCoreServicesCount;
    }

    public int getEsecoWorkflowServicesCount() {
        return esecoWorkflowServicesCount;
    }

    public void setEsecoWorkflowServicesCount(int esecoWorkflowServicesCount) {
        this.esecoWorkflowServicesCount = esecoWorkflowServicesCount;
    }
}
