package br.ufjf.pgcc.eseco.domain.model.metrics;

import java.util.ArrayList;

public class ClassInternalMetricsModel {

    private String name;
    private int parametersCount;
    private int methodsCount;
    private int servicesCount;
    private int esecoCoreServicesCount;
    private int esecoWorkflowServicesCount;
    private ArrayList<String> parametersNames;
    private ArrayList<String> methodsNames;
    private ArrayList<String> esecoCoreServicesNames;
    private ArrayList<String> esecoWorkflowServicesNames;


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

    public ArrayList<String> getParametersNames() {
        return parametersNames;
    }

    public void setParametersNames(ArrayList<String> parametersNames) {
        this.parametersNames = parametersNames;
    }

    public ArrayList<String> getMethodsNames() {
        return methodsNames;
    }

    public void setMethodsNames(ArrayList<String> methodsNames) {
        this.methodsNames = methodsNames;
    }

    public ArrayList<String> getEsecoCoreServicesNames() {
        return esecoCoreServicesNames;
    }

    public void setEsecoCoreServicesNames(ArrayList<String> esecoCoreServicesNames) {
        this.esecoCoreServicesNames = esecoCoreServicesNames;
    }

    public ArrayList<String> getEsecoWorkflowServicesNames() {
        return esecoWorkflowServicesNames;
    }

    public void setEsecoWorkflowServicesNames(ArrayList<String> esecoWorkflowServicesNames) {
        this.esecoWorkflowServicesNames = esecoWorkflowServicesNames;
    }
}
