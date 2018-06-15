/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.app.converter;

import br.ufjf.pgcc.eseco.domain.model.experiment.Port;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

/**
 *
 * @author Lenita
 */
@Component
public class PortIdToPortConverter implements Converter<String, Port> {

    @Override
    public Port convert(String id) {
        try {
            Integer portId = Integer.parseInt(id);
            Port p = new Port();
            p.setId(portId);
            return p;
        } catch (NumberFormatException e) {
            return null;
        }
    }

}
