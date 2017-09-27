/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.domain.converter;

import br.ufjf.pgcc.eseco.domain.model.core.Discipline;
import br.ufjf.pgcc.eseco.domain.service.core.DisciplineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

/**
 *
 * @author Lenita
 */
@Component
public class DisciplineIdToDisciplineConverter implements Converter<String, Discipline> {

    @Override
    public Discipline convert(String id) {
        try {
            Integer disciplineId = Integer.parseInt(id);
            Discipline d = new Discipline();
            d.setId(disciplineId);
            return d;
        } catch (NumberFormatException e) {
            return null;
        }
    }

}
