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
public enum ExperimentPhase {
    PROBLEM_INVESTIGATION("Ploblem Investigation"),
    EXPERIMENT_PROTOTYPING("Experiment Prototyping"),
    EXPERIMENT_EXECUTION("Experiment Execution"),
    RESULTS_PUBLICATION("Results Publication"),
    EXPERIMENT_FINISHED("Experiment Finished");

    public final String name;

    private ExperimentPhase(String value) {
        name = value;
    }

    public String getName() {
        return name;
    }

    public static List<ExperimentPhase> getList() {
        List<ExperimentPhase> list = new ArrayList<>();
        list.add(PROBLEM_INVESTIGATION);
        list.add(EXPERIMENT_PROTOTYPING);
        list.add(EXPERIMENT_EXECUTION);
        list.add(RESULTS_PUBLICATION);
        return list;
    }
}
