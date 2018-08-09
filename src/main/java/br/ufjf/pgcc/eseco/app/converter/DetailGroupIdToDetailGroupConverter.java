/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.app.converter;

import br.ufjf.pgcc.eseco.domain.model.experiment.DetailGroup;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

/**
 *
 * @author Lenita
 */
@Component
public class DetailGroupIdToDetailGroupConverter implements Converter<String, DetailGroup> {

    @Override
    public DetailGroup convert(String id) {
        try {
            Integer detailGroupId = Integer.parseInt(id);
            DetailGroup d = new DetailGroup();
            d.setId(detailGroupId);
            return d;
        } catch (NumberFormatException e) {
            return null;
        }
    }

}
