package br.ufjf.pgcc.eseco.domain.model.context;

import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import br.ufjf.pgcc.eseco.domain.model.experiment.Activity;
import br.ufjf.pgcc.eseco.domain.model.experiment.Experiment;
import br.ufjf.pgcc.eseco.domain.model.experiment.Workflow;
import br.ufjf.pgcc.eseco.domain.model.metrics.ClassInternalMetricsModel;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowServiceComment;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowServiceRating;

import java.util.Date;
import java.util.List;

public class WorkflowServiceContextModel {

    // Basic Component Info
    private int id;
    private String name;
    private String type;
    private String author;
    private Date dateCreated;
    private Date dateUpdated;

    // Basic Workflow Service Info
    private String wsType;
    private String wsNature;
    private String wsUrl;

    // Internal Service Info
    private String wsInternalClass;
    private ClassInternalMetricsModel wsInternalClassInternalMetrics;

    // Services used to compound this one
    private List<String> usedEsecoCoreServicesList;
    private List<String> usedEsecoWorkflowServicesStringList;
    private List<WorkflowServiceContextModel> usedEsecoWorkflowServicesList;

    // Component Usage
    private List<Activity> activitiesUsing;
    private int activitiesUsingCount;
    private List<Workflow> workflowsUsing;
    private int workflowsUsingCount;
    private List<Experiment> experimentsUsing;
    private int experimentsUsingCount;
    private List<Researcher> researchersUsing;
    private int researchersUsingCount;
    private String mostCommonArea;
    private String dateLastUsed;

    // Ratings
    private List<WorkflowServiceRating> wsRatings;
    private int totalDeveloperRatings;
    private int totalResearcherRatings;
    private int totalApprovals;
    private int totalReprovals;
    private long avgValueDocumentation;
    private long avgValueEaseOfUse;
    private long avgValueReliability;
    private long avgValuePerformance;
    private long avgValueDisponibility;

    // Comments
    private List<WorkflowServiceComment> wsComments;
    private int totalComments;


    /* CONSTRUCTORS */

    public WorkflowServiceContextModel() {

    }


    /* GETTERS/SETTERS */

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    public Date getDateUpdated() {
        return dateUpdated;
    }

    public void setDateUpdated(Date dateUpdated) {
        this.dateUpdated = dateUpdated;
    }

    public String getWsType() {
        return wsType;
    }

    public void setWsType(String wsType) {
        this.wsType = wsType;
    }

    public String getWsNature() {
        return wsNature;
    }

    public void setWsNature(String wsNature) {
        this.wsNature = wsNature;
    }

    public String getWsUrl() {
        return wsUrl;
    }

    public void setWsUrl(String wsUrl) {
        this.wsUrl = wsUrl;
    }

    public String getWsInternalClass() {
        return wsInternalClass;
    }

    public void setWsInternalClass(String wsInternalClass) {
        this.wsInternalClass = wsInternalClass;
    }

    public ClassInternalMetricsModel getWsInternalClassInternalMetrics() {
        return wsInternalClassInternalMetrics;
    }

    public void setWsInternalClassInternalMetrics(ClassInternalMetricsModel wsInternalClassInternalMetrics) {
        this.wsInternalClassInternalMetrics = wsInternalClassInternalMetrics;
    }

    public List<String> getUsedEsecoCoreServicesList() {
        return usedEsecoCoreServicesList;
    }

    public void setUsedEsecoCoreServicesList(List<String> usedEsecoCoreServicesList) {
        this.usedEsecoCoreServicesList = usedEsecoCoreServicesList;
    }

    public List<String> getUsedEsecoWorkflowServicesStringList() {
        return usedEsecoWorkflowServicesStringList;
    }

    public void setUsedEsecoWorkflowServicesStringList(List<String> usedEsecoWorkflowServicesStringList) {
        this.usedEsecoWorkflowServicesStringList = usedEsecoWorkflowServicesStringList;
    }

    public List<WorkflowServiceContextModel> getUsedEsecoWorkflowServicesList() {
        return usedEsecoWorkflowServicesList;
    }

    public void setUsedEsecoWorkflowServicesList(List<WorkflowServiceContextModel> usedEsecoWorkflowServicesList) {
        this.usedEsecoWorkflowServicesList = usedEsecoWorkflowServicesList;
    }

    public List<Activity> getActivitiesUsing() {
        return activitiesUsing;
    }

    public void setActivitiesUsing(List<Activity> activitiesUsing) {
        this.activitiesUsing = activitiesUsing;
    }

    public int getActivitiesUsingCount() {
        return activitiesUsingCount;
    }

    public void setActivitiesUsingCount(int activitiesUsingCount) {
        this.activitiesUsingCount = activitiesUsingCount;
    }

    public List<Workflow> getWorkflowsUsing() {
        return workflowsUsing;
    }

    public void setWorkflowsUsing(List<Workflow> workflowsUsing) {
        this.workflowsUsing = workflowsUsing;
    }

    public int getWorkflowsUsingCount() {
        return workflowsUsingCount;
    }

    public void setWorkflowsUsingCount(int workflowsUsingCount) {
        this.workflowsUsingCount = workflowsUsingCount;
    }

    public List<Experiment> getExperimentsUsing() {
        return experimentsUsing;
    }

    public void setExperimentsUsing(List<Experiment> experimentsUsing) {
        this.experimentsUsing = experimentsUsing;
    }

    public int getExperimentsUsingCount() {
        return experimentsUsingCount;
    }

    public void setExperimentsUsingCount(int experimentsUsingCount) {
        this.experimentsUsingCount = experimentsUsingCount;
    }

    public List<Researcher> getResearchersUsing() {
        return researchersUsing;
    }

    public void setResearchersUsing(List<Researcher> researchersUsing) {
        this.researchersUsing = researchersUsing;
    }

    public int getResearchersUsingCount() {
        return researchersUsingCount;
    }

    public void setResearchersUsingCount(int researchersUsingCount) {
        this.researchersUsingCount = researchersUsingCount;
    }

    public String getMostCommonArea() {
        return mostCommonArea;
    }

    public void setMostCommonArea(String mostCommonArea) {
        this.mostCommonArea = mostCommonArea;
    }

    public String getDateLastUsed() {
        return dateLastUsed;
    }

    public void setDateLastUsed(String dateLastUsed) {
        this.dateLastUsed = dateLastUsed;
    }

    public List<WorkflowServiceRating> getWsRatings() {
        return wsRatings;
    }

    public void setWsRatings(List<WorkflowServiceRating> wsRatings) {
        this.wsRatings = wsRatings;
    }

    public int getTotalDeveloperRatings() {
        return totalDeveloperRatings;
    }

    public void setTotalDeveloperRatings(int totalDeveloperRatings) {
        this.totalDeveloperRatings = totalDeveloperRatings;
    }

    public int getTotalResearcherRatings() {
        return totalResearcherRatings;
    }

    public void setTotalResearcherRatings(int totalResearcherRatings) {
        this.totalResearcherRatings = totalResearcherRatings;
    }

    public int getTotalApprovals() {
        return totalApprovals;
    }

    public void setTotalApprovals(int totalApprovals) {
        this.totalApprovals = totalApprovals;
    }

    public int getTotalReprovals() {
        return totalReprovals;
    }

    public void setTotalReprovals(int totalReprovals) {
        this.totalReprovals = totalReprovals;
    }

    public long getAvgValueDocumentation() {
        return avgValueDocumentation;
    }

    public void setAvgValueDocumentation(long avgValueDocumentation) {
        this.avgValueDocumentation = avgValueDocumentation;
    }

    public long getAvgValueEaseOfUse() {
        return avgValueEaseOfUse;
    }

    public void setAvgValueEaseOfUse(long avgValueEaseOfUse) {
        this.avgValueEaseOfUse = avgValueEaseOfUse;
    }

    public long getAvgValueReliability() {
        return avgValueReliability;
    }

    public void setAvgValueReliability(long avgValueReliability) {
        this.avgValueReliability = avgValueReliability;
    }

    public long getAvgValuePerformance() {
        return avgValuePerformance;
    }

    public void setAvgValuePerformance(long avgValuePerformance) {
        this.avgValuePerformance = avgValuePerformance;
    }

    public long getAvgValueDisponibility() {
        return avgValueDisponibility;
    }

    public void setAvgValueDisponibility(long avgValueDisponibility) {
        this.avgValueDisponibility = avgValueDisponibility;
    }

    public List<WorkflowServiceComment> getWsComments() {
        return wsComments;
    }

    public void setWsComments(List<WorkflowServiceComment> wsComments) {
        this.wsComments = wsComments;
    }

    public int getTotalComments() {
        return totalComments;
    }

    public void setTotalComments(int totalComments) {
        this.totalComments = totalComments;
    }
}
