package br.ufjf.pgcc.eseco.services.agriculture;

import br.ufjf.pgcc.eseco.domain.annotation.ComposedOf;
import br.ufjf.pgcc.eseco.domain.annotation.EsecoWorkflowService;
import br.ufjf.pgcc.eseco.scientificModels.agriculture.Experiment;
import com.google.gson.Gson;

import java.util.HashMap;
import java.util.Map;

@EsecoWorkflowService
@ComposedOf(servicesClasses = {
        Experiment.class
})
public class MeanExperimentDiaryWeightGain {

    public String getByExperimentId(int experimentId){
        double mean = 10;

        Map<String, Double> map = new HashMap<>();
        map.put("mean", mean);




        Gson gson = new Gson();
        return gson.toJson(map);
    }
}
