/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.app.converter;

import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowService;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

/**
 *
 * @author Lenita
 */
@Component
public class WorkflowServiceIdToWorkflowServiceConverter implements Converter<String, WorkflowService> {

    @Override
    public WorkflowService convert(String id) {
        try {
            Integer workflowServiceId = Integer.parseInt(id);
            WorkflowService i = new WorkflowService();
            i.setId(workflowServiceId);
            return i;
        } catch (NumberFormatException e) {
            return null;
        }
    }

}
