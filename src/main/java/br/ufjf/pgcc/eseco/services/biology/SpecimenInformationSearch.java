package br.ufjf.pgcc.eseco.services.biology;

import br.ufjf.pgcc.eseco.domain.annotation.ComposedOf;
import br.ufjf.pgcc.eseco.domain.annotation.EsecoWorkflowService;
import br.ufjf.pgcc.eseco.scientificModels.biology.Specimen;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;


@EsecoWorkflowService
@ComposedOf(servicesClasses = {
        Specimen.class
})
public class SpecimenInformationSearch {

    private Specimen specimen;

    private void setSpecimenByBarCode(String barCode){
        // Use the bar code to get specimen info
        String specimenInfoJsonString = "";
        JsonParser parser = new JsonParser();
        JsonObject specimenInfoJson = parser.parse(specimenInfoJsonString).getAsJsonObject();

        // Create Specimen
        specimen = new Specimen();
        specimen.setCommonName(specimenInfoJson.get("common_name").getAsString());
        specimen.setScientificName(specimenInfoJson.get("scientific_name").getAsString());
        specimen.setBarCode(barCode);
    }

    public String getSpecimenInfoByBarCode(String barCode){
        setSpecimenByBarCode(barCode);

        Gson gson = new GsonBuilder().create();

        return gson.toJson(specimen);
    }

}
