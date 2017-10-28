package br.ufjf.pgcc.eseco.app.service;

import br.ufjf.biocatalogue.core.BioCatalogueClient;
import br.ufjf.biocatalogue.exception.BioCatalogueException;
import br.ufjf.biocatalogue.model.Result;
import br.ufjf.biocatalogue.model.Search;
import br.ufjf.biocatalogue.model.ServiceData;
import br.ufjf.biocatalogue.model.User;
import br.ufjf.pgcc.eseco.app.model.WorkflowServiceSearchResult;
import org.springframework.stereotype.Service;

import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;

@Service
public class BioCatalogueService {

    private final BioCatalogueClient client;

    public BioCatalogueService() {
        client = new BioCatalogueClient();
        client.setBaseUri("https://www.biocatalogue.org");
    }

    /**
     * Method used to search a term in the BioCatalogue Repository
     *
     * @param searchQuery String with search terms
     * @param scope       Search scope (eg. "services")
     *
     * @return Results
     */
    public ArrayList<WorkflowServiceSearchResult> search(String searchQuery, String scope) throws BioCatalogueException {
        // Perform BioCatalogue Search
        searchQuery = searchQuery.replaceAll(" ", "+");
        if (scope != null && !scope.isEmpty()) {
            searchQuery += "&scope=" + scope;
        }
        Search search = client.search(searchQuery);

        // Adapt Search Results to E-Seco Search Format
        ArrayList<WorkflowServiceSearchResult> searchResults = new ArrayList<>();
        for (Result result : search.getResults()) {
            WorkflowServiceSearchResult searchResult = new WorkflowServiceSearchResult();

            // Service Name
            searchResult.setName(result.getName() != null ? result.getName() : "---");

            // Service Id
            String serviceAddress = result.getResource();
            String serviceId = serviceAddress.replace("https://www.biocatalogue.org/services/", "");
            searchResult.setServiceIdRepository(serviceId);

            // Description and Short Description
            if (result.getDescription() != null) {
                searchResult.setDescription(result.getDescription());
                if (result.getDescription().length() > 100) {
                    searchResult.setShortDescription(result.getDescription().substring(0, 100) + "...");
                } else {
                    searchResult.setShortDescription(result.getDescription());
                }
            } else {
                searchResult.setDescription("---");
                searchResult.setShortDescription("---");
            }

            // Service Misc Data
            searchResult.setCreatedAt(result.getCreated_at() != null ? result.getCreated_at() : "---");
            searchResult.setArchivedAt(result.getArchived_at() != null ? result.getArchived_at() : "---");
            searchResult.setMonitoringStatusLabel(result.getLatest_monitoring_status() != null ? result.getLatest_monitoring_status().getLabel() : "---");
            searchResult.setMonitoringStatusLastChecked(result.getLatest_monitoring_status().getLast_checked() != null ? result.getLatest_monitoring_status().getLast_checked() : "---");
            searchResult.setComponentType("Service - " + result.getService_technology_types().get(0));
            searchResult.setRepositoryName("BioCatalogue");
            searchResult.setOwner(result.getSubmitter());

            searchResults.add(searchResult);
        }

        return searchResults;
    }


    /**
     * Method used to get details from an specific resource from BioCatalogue
     *
     * @param serviceId BioCatalogue Service Id
     *
     * @return Results
     */
    public WorkflowServiceSearchResult getDetails(String serviceId) throws BioCatalogueException {
        WorkflowServiceSearchResult searchResult = new WorkflowServiceSearchResult();

        searchResult.setServiceIdRepository(serviceId);

        // Get basic data from BioCatalogue
        // @TODO: BIOCATALOGUE: get from https://www.biocatalogue.org/services/[SERVICE_ID].json

        // Author
        try {
            String ownerValue = searchResult.getOwner();
            URL url = new URL(ownerValue);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.connect();
            int code = connection.getResponseCode();
            if (code == 200) {//it checks that the page exists and does not return error
                BioCatalogueClient searchUserDataById = new BioCatalogueClient();
                searchUserDataById.setBaseUri("https://www.biocatalogue.org");
                String id = ownerValue.replace("https://www.biocatalogue.org/users/", "");
                try {
                    int b = Integer.parseInt(id);//used to verify if id is an integer
                    User userData = searchUserDataById.userData(id);
                    searchResult.setOwner(userData.getName());
                    searchResult.setOwnerCountry(userData.getUserLocation().getCountry());
                    searchResult.setOwnerCountryFlagImage(userData.getUserLocation().getFlagImagePNG());
                } catch (NumberFormatException nfe) {
                    searchResult.setOwner("---");
                }
            } else {
                searchResult.setOwner("---");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // File Location (For SOAP services)
        BioCatalogueClient searchServiceDataById = new BioCatalogueClient();
        searchServiceDataById.setBaseUri("https://www.biocatalogue.org");
        try {
            ServiceData serviceData = searchServiceDataById.serviceData(searchResult.getServiceIdRepository());
            searchResult.setFileLocation(serviceData.getServiceVariants().getWsdlLocation());
        } catch (Exception e) {
            e.printStackTrace();
        }

        return searchResult;
    }

}

