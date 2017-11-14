/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.app.converter;

import br.ufjf.pgcc.eseco.domain.model.experiment.Experiment;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

/**
 *
 * @author Lenita
 */
@Component
public class ExperimentIdToExperientConverter implements Converter<String, Experiment> {

    @Override
    public Experiment convert(String id) {
        try {
            Integer experimentId = Integer.parseInt(id);
            Experiment d = new Experiment();
            d.setId(experimentId);
            return d;
        } catch (NumberFormatException e) {
            return null;
        }
    }

}
