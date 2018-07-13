/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.domain.model.experiment;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 *
 * @author Lenita
 */
@Entity
@Table(name = "exp_workflow_activity")
public class WorkflowActivity implements Comparable<WorkflowActivity> {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "workflow_id")
    private Workflow workflow;

    @ManyToOne
    @JoinColumn(name = "activity_id")
    private Activity activity;

    @Column(name = "order_exec")
    private int orderExec;

    public WorkflowActivity() {
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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Override
    public int compareTo(WorkflowActivity o) {
        return Integer.compare(this.getOrderExec(), o.getOrderExec());
    }

}
