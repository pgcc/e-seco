/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.app.converter;

import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

/**
 *
 * @author Lenita
 */
@Component
public class ResearcherIdToResearcherConverter implements Converter<String, Researcher> {

    @Override
    public Researcher convert(String id) {
        try {
            Integer researcherId = Integer.parseInt(id);
            Researcher r = new Researcher();
            r.setId(researcherId);
            return r;
        } catch (NumberFormatException e) {
            return null;
        }
    }

}
