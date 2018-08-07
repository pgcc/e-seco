/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.domain.model.experiment;

import java.util.Objects;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

/**
 *
 * @author Lenita
 */
@Entity
@Table(name = "exp_workflow_activity")
public class WorkflowActivity implements Comparable<WorkflowActivity> {

    @EmbeddedId
    private WorkflowActivityId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("workflowId")
    private Workflow workflow;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("activityId")
    private Activity activity;

    @Column(name = "order_exec")
    private int orderExec;

    public WorkflowActivity() {
    }

    public WorkflowActivity(Workflow w, Activity a) {
        this.workflow = w;
        this.activity = a;
        this.id = new WorkflowActivityId(w.getId(), a.getId());
    }

    public Workflow getWorkflow() {
        return workflow;
    }

    public void setWorkflow(Workflow workflow) {
        this.workflow = workflow;
    }

    public Activity getActivity() {
        return activity;
    }

    public void setActivity(Activity activity) {
        this.activity = activity;
    }

    public int getOrderExec() {
        return orderExec;
    }

    public void setOrderExec(int orderExec) {
        this.orderExec = orderExec;
    }

    public WorkflowActivityId getId() {
        return id;
    }

    public void setId(WorkflowActivityId id) {
        this.id = id;
    }

    @Override
    public int compareTo(WorkflowActivity o) {
        return Integer.compare(this.getOrderExec(), o.getOrderExec());
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }

        if (o == null || getClass() != o.getClass()) {
            return false;
        }

        WorkflowActivity that = (WorkflowActivity) o;
        return Objects.equals(workflow, that.workflow)
                && Objects.equals(activity, that.activity);
    }

    @Override
    public int hashCode() {
        return Objects.hash(workflow, activity);
    }

}
