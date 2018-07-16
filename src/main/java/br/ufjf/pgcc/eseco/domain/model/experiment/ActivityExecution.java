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
@javax.persistence.Entity
@Table(name = "exp_activity_executions")
public class ActivityExecution {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "activity", nullable = false)
    private Activity activity;

    @ManyToOne
    @JoinColumn(name = "author_id", nullable = false)
    private Researcher author;

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
            name = "exp_activity_inputs",
            joinColumns = {
                @JoinColumn(name = "activity_id", nullable = false)
            },
            inverseJoinColumns = {
                @JoinColumn(name = "port_id", nullable = false)
            }
    )
    private List<Port> inputs;

    @ManyToMany
    @LazyCollection(LazyCollectionOption.FALSE)
    @JoinTable(
            name = "exp_activity_outputs",
            joinColumns = {
                @JoinColumn(name = "activity_id", nullable = false)
            },
            inverseJoinColumns = {
                @JoinColumn(name = "port_id", nullable = false)
            }
    )
    private List<Port> outputs;

    @ManyToOne
    @LazyCollection(LazyCollectionOption.FALSE)
    @JoinTable(
            name = "exp_workflow_execution_activity_execution",
            joinColumns = {
                @JoinColumn(name = "activity_execution_id", nullable = false)
            },
            inverseJoinColumns = {
                @JoinColumn(name = "workflow_execution_id", nullable = false)
            }
    )
    private WorkflowExecution workflowExecution;

    public ActivityExecution() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Activity getActivity() {
        return activity;
    }

    public void setActivity(Activity activity) {
        this.activity = activity;
    }

    public Researcher getAuthor() {
        return author;
    }

    public void setAuthor(Researcher author) {
        this.author = author;
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

    public WorkflowExecution getWorkflowExecution() {
        return workflowExecution;
    }

    public void setWorkflowExecution(WorkflowExecution workflowExecution) {
        this.workflowExecution = workflowExecution;
    }

    public boolean isNew() {
        return (this.id == 0);
    }

    @Override
    public String toString() {
        return String.valueOf(id);
    }
}
