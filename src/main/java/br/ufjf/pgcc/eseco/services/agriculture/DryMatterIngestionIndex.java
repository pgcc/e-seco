package br.ufjf.pgcc.eseco.services.agriculture;

import br.ufjf.pgcc.eseco.domain.annotation.ComposedOf;
import br.ufjf.pgcc.eseco.domain.annotation.EsecoWorkflowService;
import br.ufjf.pgcc.eseco.scientificDomain.model.agriculture.BovineExperiment;
import br.ufjf.pgcc.eseco.scientificDomain.model.agriculture.ExperimentAnimal;
import br.ufjf.pgcc.eseco.scientificDomain.model.agriculture.Meal;
import com.google.gson.Gson;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.HashMap;
import java.util.Map;

@EsecoWorkflowService
@ComposedOf(servicesClasses = {FoodDryMatterPercentage.class})
public class DryMatterIngestionIndex {

    public String getByExperimentId(int experimentId) {

        // Get experiment from database
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("PERSISTENCE_LOCAL");
        EntityManager em = emf.createEntityManager();
        BovineExperiment bovineExperiment = em.find(BovineExperiment.class, experimentId);
        em.close();

        // Obtain mean value
        double mean = 0;

        if(bovineExperiment.getExperimentAnimals().size() > 0){

            FoodDryMatterPercentage fdmp = new FoodDryMatterPercentage();

            for(ExperimentAnimal experimentAnimal : bovineExperiment.getExperimentAnimals()){

                if (experimentAnimal.getMeals().size() > 0) {
                    for(Meal meal : experimentAnimal.getMeals()){
                        String foodName = meal.getName();
                        double resultFdmp = fdmp.getPercentual(foodName);
                        mean += resultFdmp;
                    }
                }

            }
            mean = mean / bovineExperiment.getExperimentAnimals().size();
        }

        Map<String, Double> map = new HashMap<>();
        map.put("index", mean);

        Gson gson = new Gson();
        return gson.toJson(map);
    }

}
