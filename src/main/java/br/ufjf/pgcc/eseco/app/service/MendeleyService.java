/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.app.service;

import br.ufjf.pgcc.eseco.domain.model.core.Discipline;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import br.ufjf.pgcc.eseco.domain.service.core.CityService;
import br.ufjf.pgcc.eseco.domain.service.core.CountryService;
import br.ufjf.pgcc.eseco.domain.service.core.DisciplineService;
import br.ufjf.pgcc.eseco.domain.service.core.InstitutionService;
import br.ufjf.pgcc.eseco.domain.service.core.ResearcherService;
import br.ufjf.pgcc.eseco.domain.service.core.StateService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParseException;
import com.google.gson.JsonParser;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author Lenita
 */
@Service
public class MendeleyService {

    private static final Logger LOGGER = Logger.getLogger(MendeleyService.class.getName());

    private final CountryService countryService;
    private final StateService stateService;
    private final CityService cityService;
    private final InstitutionService institutionService;

    /**
     * Mendeley OAuth token exchange endpoint
     */
    private static final String OAUTH_ACCESS_TOKEN_URL = "https://api.mendeley.com/oauth/token";

    /**
     * Mendeley profiles endpoint
     */
    private static final String PROFILES_URL = "https://api.mendeley.com/profiles";

    /**
     * Mendeley profiles endpoint
     */
    private static final String DISCIPLINES_URL = "https://api.mendeley.com/subject_areas";

    /**
     * Mendeley search profiles endpoint
     */
    private static final String SEARCH_PROFILES_URL = "https://api.mendeley.com/search/profiles";

    /**
     * The app's consumer key
     */
    private final String CLIENT_ID = "4563";

    /**
     * The app's consumer secret
     */
    private final String CLIENT_SECRET = "4RsB2qVKHwHGAok6";

    /**
     * The access token used to sign requests
     */
    private MendeleyAccessToken accessToken;

    @Autowired
    public MendeleyService(CountryService countryService, StateService stateService, CityService cityService, InstitutionService institutionService) {
        this.stateService = stateService;
        this.cityService = cityService;
        this.countryService = countryService;
        this.institutionService = institutionService;

        //Constructs a new connector  
        try {
            getAccessTokenSecret();
        } catch (IOException ex) {
            LOGGER.log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Get de Access Token value
     *
     * @throws MalformedURLException
     * @throws IOException
     */
    private void getAccessTokenSecret() throws MalformedURLException, IOException {

        String authorization = CLIENT_ID + ":" + CLIENT_SECRET;
        String encodedBytes = Base64.getEncoder().encodeToString(authorization.getBytes());
        authorization = "Basic " + encodedBytes;

        URL obj = new URL(OAUTH_ACCESS_TOKEN_URL);
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();

        con.setRequestMethod("POST");
        con.setRequestProperty("Authorization", authorization);
        con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
        con.setRequestProperty("Accept", "Application/JSON");
        con.setDoOutput(true);

        try (DataOutputStream wr = new DataOutputStream(con.getOutputStream())) {
            wr.write("grant_type=client_credentials&scope=all".getBytes());
            wr.flush();
            wr.close();
        }

        try (BufferedReader in = new BufferedReader(
                new InputStreamReader(con.getInputStream()))) {
            String output;
            StringBuilder response = new StringBuilder();
            while ((output = in.readLine()) != null) {
                response.append(output);
            }

            GsonBuilder gsonBuilder = new GsonBuilder();
            gsonBuilder.registerTypeAdapter(MendeleyAccessToken.class,
                    new MendeleyAccessToken().getDeserialiser());
            Gson gson = gsonBuilder.create();
            JsonElement json = new JsonParser().parse(response.toString());
            accessToken = gson.fromJson(json, MendeleyAccessToken.class);
        }

    }

    /**
     * Find a Researcher by email
     *
     * @param email
     * @return
     * @throws java.io.IOException
     */
    public ArrayList<Researcher> searchByEmail(String email) throws IOException {

        StringBuilder url = new StringBuilder(PROFILES_URL);
        url.append("?");
        url.append("access_token=").append(accessToken.getAccessToken());
        url.append("&");
        url.append("email=").append(email);

        String response = searchGET(url.toString());
        System.out.println(response);
        return parseResearcherList(response);
    }

    /**
     * Find a Researcher by Scopus Id
     *
     * @param scopusId
     * @return
     */
    public ArrayList<Researcher> searchByScopusId(String scopusId) throws IOException {

        StringBuilder url = new StringBuilder(PROFILES_URL);
        url.append("?");
        url.append("access_token=").append(accessToken.getAccessToken());
        url.append("&");
        url.append("scopus_author_id=").append(scopusId);

        String response = searchGET(url.toString());
        return parseResearcherList(response);
    }

    /**
     * Find a Researcher by name
     *
     * @param parameters
     * @return
     */
    public ArrayList<Researcher> searchByParameters(List<String> parameters) throws IOException {

        StringBuilder url = new StringBuilder(SEARCH_PROFILES_URL);
        url.append("?");
        url.append("access_token=").append(accessToken.getAccessToken());
        StringBuilder query = new StringBuilder();
        for (String parameter : parameters) {
            parameter = parameter.replaceAll(" ", "%20");
            query.append(parameter);
            query.append("+");
        }
        query.deleteCharAt(query.length() - 1);
        url.append("&");
        url.append("query=").append(query.toString());
        url.append("&");
        url.append("limit=").append(10);

        String response = searchGET(url.toString());
        return parseResearcherList(response);
    }

    /**
     * Find the Disciplines
     *
     * @return
     */
    public ArrayList<Discipline> searchDisciplines() throws IOException {

        StringBuilder url = new StringBuilder(DISCIPLINES_URL);
        url.append("?");
        url.append("access_token=").append(accessToken.getAccessToken());

        String response = searchGET(url.toString());
        System.out.println(response);
        return parseDisciplineList(response);
    }

    /**
     * Execute GET Request
     *
     * @param url
     * @return
     * @throws MalformedURLException
     * @throws IOException
     */
    private String searchGET(String url) throws MalformedURLException, IOException {

        URL obj = new URL(url);
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();

        con.setRequestMethod("GET");
        con.setDoOutput(true);
        try (BufferedReader in = new BufferedReader(
                new InputStreamReader(con.getInputStream(), "UTF-8"))) {
            String output;
            StringBuilder response = new StringBuilder();
            while ((output = in.readLine()) != null) {
                response.append(output);
            }
            in.close();

            return response.toString();
        }
    }

    /**
     * Convert the string result into a Researcher list
     *
     * @param response
     * @return
     */
    private ArrayList<Researcher> parseResearcherList(String response) {
        GsonBuilder gsonBuilder = new GsonBuilder();
        gsonBuilder.registerTypeAdapter(Researcher.class, ResearcherService.getDeserialiser(countryService, stateService, cityService, institutionService));
        Gson gson = gsonBuilder.create();
        JsonElement json = new JsonParser().parse(response);

        Object[] array = (Object[]) java.lang.reflect.Array.newInstance(Researcher.class, 1);
        array = gson.fromJson(json, array.getClass());
        ArrayList<Researcher> list = new ArrayList<>();
        for (Object obj : array) {
            list.add((Researcher) obj);
        }
        return list;
    }

    /**
     * Convert the string result into a Discipline list
     *
     * @param response
     * @return
     */
    private ArrayList<Discipline> parseDisciplineList(String response) {
        GsonBuilder gsonBuilder = new GsonBuilder();
        gsonBuilder.registerTypeAdapter(Discipline.class, DisciplineService.getDeserialiser());
        Gson gson = gsonBuilder.create();
        JsonElement json = new JsonParser().parse(response);

        Object[] array = (Object[]) java.lang.reflect.Array.newInstance(Discipline.class, 1);
        array = gson.fromJson(json, array.getClass());
        ArrayList<Discipline> list = new ArrayList<>();
        for (Object obj : array) {
            list.add((Discipline) obj);
        }
        return list;
    }

    private class MendeleyAccessToken {

        private String accessToken;
        private String tokenType;
        private int expiresIn;

        public MendeleyAccessToken(String access_token, String token_type, int expires_in) {
            this.accessToken = access_token;
            this.tokenType = token_type;
            this.expiresIn = expires_in;
        }

        public MendeleyAccessToken() {
        }

        public String getAccessToken() {
            return accessToken;
        }

        public void setAccessToken(String accessToken) {
            this.accessToken = accessToken;
        }

        public String getTokenType() {
            return tokenType;
        }

        public void setTokenType(String tokenType) {
            this.tokenType = tokenType;
        }

        public int getExpiresIn() {
            return expiresIn;
        }

        public void setExpiresIn(int expiresIn) {
            this.expiresIn = expiresIn;
        }

        public Deserialiser getDeserialiser() {
            return new Deserialiser();
        }

        private class Deserialiser implements
                JsonDeserializer<MendeleyAccessToken> {

            @Override
            public MendeleyAccessToken deserialize(JsonElement je, Type type, JsonDeserializationContext jdc) throws JsonParseException {
                final MendeleyAccessToken at = new MendeleyAccessToken();
                JsonObject object = je.getAsJsonObject();

                try {
                    at.accessToken = object.get("access_token").getAsString();
                    at.tokenType = object.get("token_type").getAsString();
                    at.expiresIn = object.get("expires_in").getAsInt();

                } catch (Exception e) {
                    LOGGER.log(Level.SEVERE, null, e);
                }
                return at;
            }
        }
    }
}
