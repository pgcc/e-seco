package br.ufjf.pgcc.eseco.domain.model.context;

import java.util.Date;

public class WorkflowServiceRatingContextModel {

    private int id;
    private int workflowServiceId;
    private int type;
    private String workflowServiceName;
    private String authorName;
    private Date dateCreated;
    private String isApproved;
    private int valueDocumentation;
    private int valueEaseOfUse;
    private int valueReliability;
    private int valuePerformance;
    private int valueDisponibility;


    /* CONSTRUCTORS */

    public WorkflowServiceRatingContextModel() {

    }


    /* GETTERS/SETTERS */

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getWorkflowServiceId() {
        return workflowServiceId;
    }

    public void setWorkflowServiceId(int workflowServiceId) {
        this.workflowServiceId = workflowServiceId;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getWorkflowServiceName() {
        return workflowServiceName;
    }

    public void setWorkflowServiceName(String workflowServiceName) {
        this.workflowServiceName = workflowServiceName;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    public int getValueDocumentation() {
        return valueDocumentation;
    }

    public void setValueDocumentation(int valueDocumentation) {
        this.valueDocumentation = valueDocumentation;
    }

    public int getValueEaseOfUse() {
        return valueEaseOfUse;
    }

    public void setValueEaseOfUse(int valueEaseOfUse) {
        this.valueEaseOfUse = valueEaseOfUse;
    }

    public int getValueReliability() {
        return valueReliability;
    }

    public void setValueReliability(int valueReliability) {
        this.valueReliability = valueReliability;
    }

    public int getValuePerformance() {
        return valuePerformance;
    }

    public void setValuePerformance(int valuePerformance) {
        this.valuePerformance = valuePerformance;
    }

    public int getValueDisponibility() {
        return valueDisponibility;
    }

    public void setValueDisponibility(int valueDisponibility) {
        this.valueDisponibility = valueDisponibility;
    }

    public String getIsApproved() {
        return isApproved;
    }

    public void setIsApproved(String isApproved) {
        this.isApproved = isApproved;
    }
}
