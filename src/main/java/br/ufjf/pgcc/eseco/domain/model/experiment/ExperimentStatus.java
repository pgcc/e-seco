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
public enum ExperimentStatus {
    IN_PROGRESS("In Progress"),
    FINISHED("Finished");

    public final String name;

    private ExperimentStatus(String value) {
        name = value;
    }

    public String getName() {
        return name;
    }

    public static List<ExperimentStatus> getList() {
        List<ExperimentStatus> list = new ArrayList<>();
        list.add(IN_PROGRESS);
        list.add(FINISHED);
        return list;
    }
}
