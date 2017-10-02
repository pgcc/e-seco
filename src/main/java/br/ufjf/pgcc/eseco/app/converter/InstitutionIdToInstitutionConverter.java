/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.app.converter;

import br.ufjf.pgcc.eseco.domain.model.core.Institution;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

/**
 *
 * @author Lenita
 */
@Component
public class InstitutionIdToInstitutionConverter implements Converter<String, Institution> {

    @Override
    public Institution convert(String id) {
        try {
            Integer institutionId = Integer.parseInt(id);
            Institution i = new Institution();
            i.setId(institutionId);
            return i;
        } catch (NumberFormatException e) {
            return null;
        }
    }

}
