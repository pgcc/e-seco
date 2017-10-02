/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.app.converter;

import br.ufjf.pgcc.eseco.domain.model.experiment.Workflow;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

/**
 *
 * @author Lenita
 */
@Component
public class WorkflowIdToWorkflowConverter implements Converter<String, Workflow> {

    @Override
    public Workflow convert(String id) {
        try {
            Integer workflowId = Integer.parseInt(id);
            Workflow r = new Workflow();
            r.setId(workflowId);
            return r;
        } catch (NumberFormatException e) {
            return null;
        }
    }

}
