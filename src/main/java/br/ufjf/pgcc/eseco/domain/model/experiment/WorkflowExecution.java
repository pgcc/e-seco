/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.domain.model.experiment;

import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import java.util.Date;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.springframework.format.annotation.DateTimeFormat;

/**
 *
 * @author Lenita
 */
@Entity
@Table(name = "exp_workflow_executions")
public class WorkflowExecution {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "workflow", nullable = false)
    private Workflow workflow;

    @ManyToOne
    @JoinColumn(name = "author_id", nullable = false)
    private Researcher author;

    @ManyToOne
    @JoinColumn(name = "experiment_id", nullable = false)
    private Experiment experiment;

    @Column(name = "start_time", columnDefinition = "DATETIME")
    @Temporal(value = TemporalType.TIMESTAMP)
    @DateTimeFormat(pattern = "yyyy/MM/dd hh:mm")
    private Date startTime;

    @Column(name = "end_time", columnDefinition = "DATETIME")
    @Temporal(value = TemporalType.TIMESTAMP)
    @DateTimeFormat(pattern = "yyyy/MM/dd hh:mm")
    private Date endTime;

    @ManyToMany
    @LazyCollection(LazyCollectionOption.FALSE)
    @JoinTable(
            name = "exp_workflow_execution_activity_execution",
            joinColumns = {
                @JoinColumn(name = "workflow_execution_id", nullable = false)
            },
            inverseJoinColumns = {
                @JoinColumn(name = "activity_execution_id", nullable = false)
            }
    )
    private List<ActivityExecution> activityExecutions;

    @ManyToMany
    @LazyCollection(LazyCollectionOption.FALSE)
    @JoinTable(
            name = "exp_workflow_inputs",
            joinColumns = {
                @JoinColumn(name = "workflow_id", nullable = false)
            },
            inverseJoinColumns = {
                @JoinColumn(name = "port_id", nullable = false)
            }
    )
    private List<Port> inputs;

    @ManyToMany
    @LazyCollection(LazyCollectionOption.FALSE)
    @JoinTable(
            name = "exp_workflow_outputs",
            joinColumns = {
                @JoinColumn(name = "workflow_id", nullable = false)
            },
            inverseJoinColumns = {
                @JoinColumn(name = "port_id", nullable = false)
            }
    )
    private List<Port> outputs;

    public WorkflowExecution() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Workflow getWorkflow() {
        return workflow;
    }

    public void setWorkflow(Workflow workflow) {
        this.workflow = workflow;
    }

    public Researcher getAuthor() {
        return author;
    }

    public void setAuthor(Researcher author) {
        this.author = author;
    }

    public Experiment getExperiment() {
        return experiment;
    }

    public void setExperiment(Experiment experiment) {
        this.experiment = experiment;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public List<Port> getInputs() {
        return inputs;
    }

    public void setInputs(List<Port> inputs) {
        this.inputs = inputs;
    }

    public List<Port> getOutputs() {
        return outputs;
    }

    public void setOutputs(List<Port> outputs) {
        this.outputs = outputs;
    }

    public List<ActivityExecution> getActivityExecutions() {
        return activityExecutions;
    }

    public void setActivityExecutions(List<ActivityExecution> activityExecutions) {
        this.activityExecutions = activityExecutions;
    }

    public boolean isNew() {
        return (this.id == 0);
    }

}
