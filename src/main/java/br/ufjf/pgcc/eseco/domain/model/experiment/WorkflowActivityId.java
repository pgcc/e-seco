/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.domain.model.experiment;

import java.io.Serializable;
import java.util.Objects;
import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 *
 * @author Lenita
 */
@Embeddable
public class WorkflowActivityId
        implements Serializable {

    @Column(name = "workflow_id")
    private int workflowId;

    @Column(name = "activity_id")
    private int activityId;

    public WorkflowActivityId(int workflowId, int activityId) {
        this.workflowId = workflowId;
        this.activityId = activityId;
    }

    public WorkflowActivityId() {
    }

    //Getters omitted for brevity
    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }

        if (o == null || getClass() != o.getClass()) {
            return false;
        }

        WorkflowActivityId that = (WorkflowActivityId) o;
        return Objects.equals(workflowId, that.workflowId)
                && Objects.equals(activityId, that.activityId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(workflowId, activityId);
    }
}
