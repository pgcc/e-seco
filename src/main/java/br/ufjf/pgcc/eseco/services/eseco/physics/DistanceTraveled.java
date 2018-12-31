package br.ufjf.pgcc.eseco.services.eseco.physics;

import br.ufjf.pgcc.eseco.domain.annotation.EsecoWorkflowService;
import com.google.gson.Gson;

import java.util.HashMap;
import java.util.Map;

@EsecoWorkflowService
public class DistanceTraveled {

    /**
     * @param initialSpeed Initial Speed
     * @param finalSpeed   Final Speed
     * @param acceleration Acceleration
     *
     * @return Json with Distance Traveled Data
     */
    public String getJson(String initialSpeed, String finalSpeed, String acceleration) {
        // Convert Parameters
        double convertedInitialSpeed = Double.parseDouble(initialSpeed);
        double convertedFinalSpeed = Double.parseDouble(finalSpeed);
        double convertedAcceleration = Double.parseDouble(acceleration);

        // Create map of return data
        Map<String, Double> returnMap = new HashMap<>();
        returnMap.put("distance",
            this.getDistanceTraveled(convertedInitialSpeed, convertedFinalSpeed, convertedAcceleration)
        );

        // Return the mapped data
        Gson gson = new Gson();
        return gson.toJson(returnMap);
    }

    /**
     * @param initialSpeed Initial Speed
     * @param finalSpeed   Final Speed
     * @param acceleration Acceleration
     *
     * @return Distance Traveled
     */
    private double getDistanceTraveled(double initialSpeed, double finalSpeed, double acceleration) {
        double time = (finalSpeed - initialSpeed) / acceleration;
        double distance = (initialSpeed * time) + (.5 * acceleration * (time * time));

        return distance;
    }

}
