/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.app.converter;

import br.ufjf.pgcc.eseco.domain.model.experiment.ActivityExecution;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

/**
 *
 * @author Lenita
 */
@Component
public class ActivityExecutionIdToActivityExecutionConverter implements Converter<String, ActivityExecution> {

    @Override
    public ActivityExecution convert(String id) {
        try {
            Integer activityId = Integer.parseInt(id);
            ActivityExecution a = new ActivityExecution();
            a.setId(activityId);
            return a;
        } catch (NumberFormatException e) {
            return null;
        }
    }

}
