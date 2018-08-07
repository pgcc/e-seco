/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.domain.model.experiment;

import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Objects;
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
@Table(name = "exp_workflows")
public class Workflow {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "name")
    private String name;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "link")
    private String link;

    @Column(name = "value", columnDefinition = "TEXT")
    private String value;

    @ManyToOne
    @JoinColumn(name = "wfms", nullable = false)
    private Wfms wfms;

    @ManyToOne
    @JoinColumn(name = "author_id", nullable = false)
    private Researcher author;

    @Column(name = "date_created", columnDefinition = "DATE")
    @Temporal(value = TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy/MM/dd")
    private Date dateCreated;

    @Column(name = "version")
    private String version;

    @OneToMany(
            mappedBy = "workflow",
            cascade = CascadeType.ALL,
            orphanRemoval = true,
            fetch = FetchType.EAGER
    )
    private List<WorkflowActivity> activities;

    @ManyToMany(mappedBy = "workflows")
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<Experiment> experiments;

    @OneToMany(mappedBy = "workflow")
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<WorkflowExecution> executions;

    public Workflow() {
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

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public Wfms getWfms() {
        return wfms;
    }

    public void setWfms(Wfms wfms) {
        this.wfms = wfms;
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

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public List<WorkflowActivity> getActivities() {
        return activities;
    }

    public void setActivities(List<WorkflowActivity> activities) {
        this.activities = activities;
    }

    public List<Experiment> getExperiments() {
        return experiments;
    }

    public void setExperiments(List<Experiment> experiments) {
        this.experiments = experiments;
    }

    public List<WorkflowExecution> getExecutions() {
        return executions;
    }

    public void setExecutions(List<WorkflowExecution> executions) {
        this.executions = executions;
    }

    public void addActivity(Activity a) {
        if (activities == null) {
            activities = new ArrayList<>();
        }
        WorkflowActivity workflowActivity = new WorkflowActivity(this, a);
        activities.add(workflowActivity);
        a.getWorkflows().add(workflowActivity);
    }

    public void removeActivity(Activity a) {
        if (activities == null) {
            return;
        }
        for (Iterator<WorkflowActivity> iterator = activities.iterator();
                iterator.hasNext();) {
            WorkflowActivity workflowActivity = iterator.next();

            if (workflowActivity.getWorkflow().equals(this)
                    && workflowActivity.getActivity().getId() == a.getId()) {
                iterator.remove();
                workflowActivity.getActivity().getWorkflows().remove(workflowActivity);
                workflowActivity.setWorkflow(null);
                workflowActivity.setActivity(null);
            }
        }
    }

    public boolean isNew() {
        return (this.id == 0);
    }

    @Override
    public String toString() {
        return String.valueOf(id);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        Workflow w = (Workflow) o;
        return Objects.equals(id, w.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

}
