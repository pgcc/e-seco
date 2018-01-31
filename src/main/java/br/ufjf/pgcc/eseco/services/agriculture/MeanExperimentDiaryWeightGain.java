package br.ufjf.pgcc.eseco.services.agriculture;

import br.ufjf.pgcc.eseco.domain.annotation.ComposedOf;
import br.ufjf.pgcc.eseco.domain.annotation.EsecoWorkflowService;
import br.ufjf.pgcc.eseco.scientificDomain.model.agriculture.BovineExperiment;
import br.ufjf.pgcc.eseco.scientificDomain.model.agriculture.ExperimentAnimal;
import com.google.gson.Gson;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.HashMap;
import java.util.Map;

@EsecoWorkflowService
@ComposedOf(servicesClasses = {
        BovineExperiment.class
})
public class MeanExperimentDiaryWeightGain {

    public String getByExperimentId(int experimentId){

        // Prepare json return schema
        Map<String, Double> map = new HashMap<>();
        map.put("mean", getGPD(experimentId));

        // Return converted json schema to json string
        Gson gson = new Gson();
        return gson.toJson(map);
    }
    public double getGPD(int experimentId){

        // Get experiment from database
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("PERSISTENCE_LOCAL");
        EntityManager em = emf.createEntityManager();
        BovineExperiment bovineExperiment = em.find(BovineExperiment.class, experimentId);
        em.close();

        // Obtain mean value
        double mean = 0;
        if(bovineExperiment.getExperimentAnimals().size() > 0){
            for(ExperimentAnimal experimentAnimal : bovineExperiment.getExperimentAnimals()){
                mean += experimentAnimal.getDiaryWeightGain();
            }
            mean = mean / bovineExperiment.getExperimentAnimals().size();
        }
        return mean;

    }
}
