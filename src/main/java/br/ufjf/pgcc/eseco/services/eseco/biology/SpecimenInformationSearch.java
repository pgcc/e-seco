package br.ufjf.pgcc.eseco.services.eseco.biology;

import br.ufjf.pgcc.eseco.domain.annotation.ComposedOf;
import br.ufjf.pgcc.eseco.domain.annotation.EsecoWorkflowService;
import br.ufjf.pgcc.eseco.scientificDomain.model.eseco.biology.Specimen;
import br.ufjf.pgcc.eseco.scientificDomain.model.eseco.biology.SpecimenCollectionType;
import com.google.gson.*;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.springframework.http.HttpHeaders.USER_AGENT;

@Service
@EsecoWorkflowService
@ComposedOf(classes = {
        Specimen.class,
        SpecimenCollectionType.class
})
public class SpecimenInformationSearch {

    /**
     * @param collectionType The name of the collection
     *
     * @return A list of specimens of that collection
     *
     * @throws IOException Exception
     */
    public String getSpecimensByCollectionType(String collectionType) throws IOException {

        // Consumes an external API
        String url = "https://api.biodiversitydata.nl/v2/specimen/query?collectionType=" + collectionType;

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

        // Prepare the list of Specimens that will be returned
        ArrayList<Specimen> specimens = new ArrayList<>();

        // Parse the returned json response
        String specimensJsonString = response.toString();
        JsonParser parser = new JsonParser();
        JsonObject specimensJson = parser.parse(specimensJsonString).getAsJsonObject();

        // Loop through the specimens json data
        JsonArray specimensArray = specimensJson.getAsJsonArray("resultSet");
        for (JsonElement jsonElement : specimensArray) {
            // Get the speciment identifications
            JsonObject jsonObject = jsonElement.getAsJsonObject();
            JsonArray identificationsArray = jsonObject.getAsJsonObject("item").getAsJsonArray("identifications");

            // Take the first identification of the specimen, ignore the rest
            if (identificationsArray.size() >= 1) {
                JsonObject firstIdentification = identificationsArray.get(0).getAsJsonObject();
                JsonObject scientificIdentifications = firstIdentification.getAsJsonObject("scientificName");
                JsonObject classification = firstIdentification.getAsJsonObject("defaultClassification");

                // Get the desired data to extract
                JsonElement scientificName = scientificIdentifications.get("fullScientificName");
                JsonElement classificationOrder = classification.get("order");
                JsonElement classificationFamily = classification.get("family");
                JsonElement classificationGenus = classification.get("genus");

                // Create an Specimen object to hold the desired data
                Specimen newSpecimen = new Specimen();
                newSpecimen.setScientificName(scientificName != null ? scientificName.getAsString() : "");
                newSpecimen.setClassificationOrder(classificationOrder != null ? classificationOrder.getAsString() : "");
                newSpecimen.setClassificationFamily(classificationFamily != null ? classificationFamily.getAsString() : "");
                newSpecimen.setClassificationGenus(classificationGenus != null ? classificationGenus.getAsString() : "");

                // Add the new Specimen object to the return list
                specimens.add(newSpecimen);
            }
        }

        // Prepare json return schema
        Map<String, ArrayList<Specimen>> map = new HashMap<>();
        map.put("specimens", specimens);

        // Return converted json schema to json string
        Gson gson = new Gson();
        return gson.toJson(map);
    }

    /**
     * @return A list of collection types
     */
    public String getSpecimenCollectionTypes() {
        // Get Entity Manager
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("PERSISTENCE_LOCAL");
        EntityManager em = emf.createEntityManager();

        // Get Specimen Collection Types
        CriteriaBuilder criteriaBuilder = em.getCriteriaBuilder();
        CriteriaQuery<SpecimenCollectionType> criteriaQuery = criteriaBuilder.createQuery(SpecimenCollectionType.class);
        Root<SpecimenCollectionType> root = criteriaQuery.from(SpecimenCollectionType.class);
        criteriaQuery.select(root);
        TypedQuery<SpecimenCollectionType> results = em.createQuery(criteriaQuery);
        List<SpecimenCollectionType> specimenCollectionTypes = results.getResultList();
        em.close();

        // Prepare json return schema
        Map<String, List<SpecimenCollectionType>> map = new HashMap<>();
        map.put("specimen_collection_types", specimenCollectionTypes);

        // Return converted json schema to json string
        Gson gson = new Gson();
        return gson.toJson(map);
    }

}
