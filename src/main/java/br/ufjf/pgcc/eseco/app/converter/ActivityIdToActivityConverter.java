/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.app.converter;

import br.ufjf.pgcc.eseco.domain.model.experiment.Activity;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

/**
 *
 * @author Lenita
 */
@Component
public class ActivityIdToActivityConverter implements Converter<String, Activity> {

    @Override
    public Activity convert(String id) {
        try {
            Integer activityId = Integer.parseInt(id);
            Activity a = new Activity();
            a.setId(activityId);
            return a;
        } catch (NumberFormatException e) {
            return null;
        }
    }

}
