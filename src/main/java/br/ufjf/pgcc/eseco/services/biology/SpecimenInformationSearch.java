package br.ufjf.pgcc.eseco.services.biology;

import br.ufjf.pgcc.eseco.domain.annotation.ComposedOf;
import br.ufjf.pgcc.eseco.domain.annotation.EsecoWorkflowService;
import br.ufjf.pgcc.eseco.scientificDomain.model.biology.Specimen;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import static org.springframework.http.HttpHeaders.USER_AGENT;


@EsecoWorkflowService
@ComposedOf(servicesClasses = {
        Specimen.class
})
public class SpecimenInformationSearch {

    private Specimen specimen;

    private void setSpecimenByBarCode(String barCode) throws IOException {
        String url = "http://newbiosystems.com/api/specimen-details/by-barcode/" + barCode;

        URL obj = new URL(url);
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();
        con.setRequestMethod("GET");
        con.setRequestProperty("User-Agent", USER_AGENT);

        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String inputLine;
        StringBuilder response = new StringBuilder();

        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();

        // Use the bar code to get specimen info
        String specimenInfoJsonString = response.toString();
        JsonParser parser = new JsonParser();
        JsonObject specimenInfoJson = parser.parse(specimenInfoJsonString).getAsJsonObject();

        // Create Specimen
        specimen = new Specimen();
        specimen.setCommonName(specimenInfoJson.get("common_name").getAsString());
        specimen.setScientificName(specimenInfoJson.get("scientific_name").getAsString());
        specimen.setBarCode(barCode);
    }

    public String getSpecimenInfoByBarCode(String barCode) throws IOException {
        setSpecimenByBarCode(barCode);

        Gson gson = new GsonBuilder().create();

        return gson.toJson(specimen);
    }

}
