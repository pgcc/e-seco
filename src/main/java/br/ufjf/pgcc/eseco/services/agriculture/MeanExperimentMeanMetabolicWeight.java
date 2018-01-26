package br.ufjf.pgcc.eseco.services.agriculture;

import br.ufjf.pgcc.eseco.domain.annotation.ComposedOf;
import br.ufjf.pgcc.eseco.domain.annotation.EsecoWorkflowService;
import br.ufjf.pgcc.eseco.scientificModels.agriculture.BovineExperiment;
import com.google.gson.Gson;

import java.util.HashMap;
import java.util.Map;

@EsecoWorkflowService
@ComposedOf(servicesClasses = {
        BovineExperiment.class
})
public class MeanExperimentMeanMetabolicWeight {

    public String getByExperimentId(int experimentId){
        double mean = 12;

        Map<String, Double> map = new HashMap<>();
        map.put("mean", mean);

        



        Gson gson = new Gson();
        return gson.toJson(map);
    }
}
