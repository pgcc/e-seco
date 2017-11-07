/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.domain.model.experiment;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Lenita
 */
public enum EntityKind {
    DATA("Data"),
    DOCUMENT("Document");

    public final String name;

    private EntityKind(String value) {
        name = value;
    }

    public String getName() {
        return name;
    }

    public static List<EntityKind> getList() {
        List<EntityKind> list = new ArrayList<>();
        list.add(DATA);
        list.add(DOCUMENT);
        return list;
    }
}
