/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.app.converter;

import br.ufjf.pgcc.eseco.domain.model.core.ResearchGroup;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

/**
 *
 * @author Lenita
 */
@Component
public class ResearchGroupIdToResearchGroupConverter implements Converter<String, ResearchGroup> {

    @Override
    public ResearchGroup convert(String id) {
        try {
            Integer researchGroupId = Integer.parseInt(id);
            ResearchGroup rg = new ResearchGroup();
            rg.setId(researchGroupId);
            return rg;
        } catch (NumberFormatException e) {
            return null;
        }
    }

}
