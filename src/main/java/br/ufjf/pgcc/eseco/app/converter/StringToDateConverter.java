/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.app.converter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.springframework.core.convert.converter.Converter;

/**
 *
 * @author LenitaMA
 */
public class StringToDateConverter implements Converter<String, Date> {

    private static final Logger LOGGER = Logger.getLogger(StringToDateConverter.class.getName());

    @Override
    public Date convert(String source) {
        SimpleDateFormat sf = new SimpleDateFormat("yyyy/MM/dd");
        if (!source.isEmpty()) {
            if (source.length() == 16) {
                sf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
            }
            try {
                return sf.parse(source);
            } catch (ParseException e) {
                LOGGER.log(Level.SEVERE, e.getLocalizedMessage());
            }
        }
        return null;

    }

}
