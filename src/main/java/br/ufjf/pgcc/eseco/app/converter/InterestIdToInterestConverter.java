/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.app.converter;

import br.ufjf.pgcc.eseco.domain.model.core.Interest;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

/**
 *
 * @author Lenita
 */
@Component
public class InterestIdToInterestConverter implements Converter<String, Interest> {

    @Override
    public Interest convert(String id) {
        try {
            Integer disciplineId = Integer.parseInt(id);
            Interest d = new Interest();
            d.setId(disciplineId);
            return d;
        } catch (NumberFormatException e) {
            return null;
        }
    }

}
