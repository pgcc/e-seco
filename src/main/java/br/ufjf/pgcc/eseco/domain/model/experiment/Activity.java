/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.domain.model.experiment;

import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowService;

import java.util.Date;
import java.util.List;
import javax.persistence.*;
import javax.persistence.Entity;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.springframework.format.annotation.DateTimeFormat;

/**
 *
 * @author Lenita
 */
@Entity
@Table(name = "exp_activities")
public class Activity {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "name")
    private String name;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @ManyToOne
    @JoinColumn(name = "author_id")
    private Researcher author;

    @Column(name = "date_created", columnDefinition = "DATE")
    @Temporal(value = TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy/MM/dd")
    private Date dateCreated;

    @ManyToMany()
    @LazyCollection(LazyCollectionOption.FALSE)
    @JoinTable(
            name = "exp_activities_workflowservices",
            joinColumns = {
                @JoinColumn(name = "activity_id", nullable = false)
            },
            inverseJoinColumns = {
                @JoinColumn(name = "workflowservice_id", nullable = false)
            }
    )
    private List<WorkflowService> workflowServices;

    @ManyToMany
    @LazyCollection(LazyCollectionOption.FALSE)
    @JoinTable(
            name = "exp_workflow_activity",
            joinColumns = {
                @JoinColumn(name = "activity_id", nullable = false)
            },
            inverseJoinColumns = {
                @JoinColumn(name = "workflow_id", nullable = false)
            }
    )
    private List<Workflow> workflows;

    @OneToMany(cascade = CascadeType.ALL)
    @LazyCollection(LazyCollectionOption.FALSE)
    @JoinTable(
            name = "exp_activity_detail",
            joinColumns = {
                @JoinColumn(name = "activity_id", nullable = false)
            },
            inverseJoinColumns = {
                @JoinColumn(name = "detail_id", nullable = false)
            }
    )
    private List<Detail> details;

    @OneToMany(mappedBy = "activity", fetch = FetchType.EAGER)
    private List<ActivityExecution> executions;

    public Activity() {
    }

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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Researcher getAuthor() {
        return author;
    }

    public void setAuthor(Researcher author) {
        this.author = author;
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    public List<WorkflowService> getWorkflowServices() {
        return workflowServices;
    }

    public void setWorkflowServices(List<WorkflowService> workflowServices) {
        this.workflowServices = workflowServices;
    }

    public List<ActivityExecution> getExecutions() {
        return executions;
    }

    public void setExecutions(List<ActivityExecution> executions) {
        this.executions = executions;
    }

    public boolean isNew() {
        return (this.id == 0);
    }

    @Override
    public String toString() {
        return String.valueOf(id);
    }

    public List<Workflow> getWorkflows() {
        return workflows;
    }

    public void setWorkflows(List<Workflow> workflows) {
        this.workflows = workflows;
    }

    public List<Detail> getDetails() {
        return details;
    }

    public void setDetails(List<Detail> details) {
        this.details = details;
    }

}
