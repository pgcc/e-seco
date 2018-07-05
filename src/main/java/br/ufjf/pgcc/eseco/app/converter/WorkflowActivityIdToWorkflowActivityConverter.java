/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.app.converter;

import br.ufjf.pgcc.eseco.domain.model.experiment.WorkflowActivity;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

/**
 *
 * @author Lenita
 */
@Component
public class WorkflowActivityIdToWorkflowActivityConverter implements Converter<String, WorkflowActivity> {

    @Override
    public WorkflowActivity convert(String id) {
        try {
            Integer waId = Integer.parseInt(id);
            WorkflowActivity wa = new WorkflowActivity();
            wa.setId(waId);
            return wa;
        } catch (NumberFormatException e) {
            return null;
        }
    }

}
