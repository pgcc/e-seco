package br.ufjf.pgcc.eseco.services.eseco.physics;

import br.ufjf.pgcc.eseco.domain.annotation.ComposedOf;
import br.ufjf.pgcc.eseco.domain.annotation.EsecoWorkflowService;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.util.HashMap;
import java.util.Map;

@EsecoWorkflowService
@ComposedOf(classes = {DistanceTraveled.class})
public class AccelerationCalculator {

    /**
     * @param initialSpeed Initial Speed
     * @param finalSpeed   Final Speed
     * @param time         Time
     *
     * @return Acceleration Data
     */
    public String getJson(String initialSpeed, String finalSpeed, String time) {
        // Convert Parameters
        double convertedInitialSpeed = Double.parseDouble(initialSpeed);
        double convertedFinalSpeed = Double.parseDouble(finalSpeed);
        double convertedTime = Double.parseDouble(time);

        // Get Acceleration Value
        double acceleration = this.getAcceleration(convertedInitialSpeed, convertedFinalSpeed, convertedTime);

        // Get Distance Traveled Value
        DistanceTraveled distanceTraveled = new DistanceTraveled();
        String distanceJsonString = distanceTraveled.getJson(initialSpeed, finalSpeed, String.valueOf(acceleration));
        JsonParser parser = new JsonParser();
        JsonObject o = parser.parse(distanceJsonString).getAsJsonObject();
        JsonElement el = o.get("distance");
        String distanceString = el.getAsString();
        double distance = Double.parseDouble(distanceString);

        // Create map of return data
        Map<String, Double> returnMap = new HashMap<>();
        returnMap.put("acceleration", acceleration);
        returnMap.put("distance_traveled", distance);

        // Return the mapped data
        Gson gson = new Gson();
        return gson.toJson(returnMap);
    }

    /**
     * @param initialSpeed Initial Speed
     * @param finalSpeed   Final Speed
     * @param time         Time
     *
     * @return Acceleration value
     */
    private double getAcceleration(double initialSpeed, double finalSpeed, double time) {
        return (finalSpeed - initialSpeed) / time;
    }

}
