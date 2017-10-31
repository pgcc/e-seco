package br.ufjf.pgcc.eseco.domain.model.context;

import java.util.Date;

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
    private int wsClassParameterCount;
    private int wsClassMethodCount;
    //private int wsClassAtomicServicesCount;
    //private int wsClassEsecoClassesCount;


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

    public int getWsClassParameterCount() {
        return wsClassParameterCount;
    }

    public void setWsClassParameterCount(int wsClassParameterCount) {
        this.wsClassParameterCount = wsClassParameterCount;
    }

    public int getWsClassMethodCount() {
        return wsClassMethodCount;
    }

    public void setWsClassMethodCount(int wsClassMethodCount) {
        this.wsClassMethodCount = wsClassMethodCount;
    }
}
