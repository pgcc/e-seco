package br.ufjf.pgcc.eseco.services.agriculture;


import br.ufjf.pgcc.eseco.domain.annotation.EsecoWorkflowService;
import com.google.gson.Gson;

import java.util.HashMap;
import java.util.Map;

@EsecoWorkflowService
public class FoodDryMatterPercentage {

    public String getByFoodName(String foodName){

        Map<String, Double> map = new HashMap<>();
        map.put("percentage", getPercentual(foodName));

        Gson gson = new Gson();
        return gson.toJson(map);
    }

    public double getPercentual(String foodName) {
        double percentage = 0;

        if(foodName.toLowerCase().equals("corn")){
            percentage = 27.0;
        }else if(foodName.toLowerCase().equals("soy")){
            percentage = 90.0;
        }else if(foodName.toLowerCase().equals("silage")){
            percentage = 75.0;
        }

        return percentage;
    }

}
