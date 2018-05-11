/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.app.service;

import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.ws.http.HTTPException;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 *
 * @author Lenita
 */
@Service
public class ProvSeOGetInferencesService {

    private static final Logger LOGGER = Logger.getLogger(MendeleyService.class.getName());

    @Autowired
    public ProvSeOGetInferencesService() {

    }

    public void testURL() throws IOException {
        try {
            URL u = new URL("http://localhost:8080/provse-service/webresources/ontology/");

            HttpURLConnection urlConn = (HttpURLConnection) u.openConnection();
            urlConn.connect();
//            assertEquals(HttpURLConnection.HTTP_OK, urlConn.getResponseCode());
        } catch (IOException e) {
            System.err.println("Error creating HTTP connection");
            e.printStackTrace();
            throw e;
        }
    }

    public void callOntologyService(JsonObject rawData) throws IOException {
        try {
            String type = "application/json";
            byte[] encodedData = rawData.toString().getBytes(StandardCharsets.UTF_8);
            URL u = new URL("http://localhost:8080/provse-service/webresources/ontology/");
            HttpURLConnection conn = (HttpURLConnection) u.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("PUT");
            conn.setRequestProperty("Content-Type", type);
            conn.setRequestProperty("Content-Length", String.valueOf(encodedData.length));
            OutputStream os = conn.getOutputStream();
            os.write(encodedData);
            conn.connect();
            if (conn.getResponseCode() != HttpStatus.OK.value()) {
                System.out.println(conn.getResponseMessage() + " === " + conn.getResponseCode());
                throw new HTTPException(conn.getResponseCode());
            }
        } catch (IOException ex) {
            ex.printStackTrace();
            throw ex;
        }
    }

    public JSONObject getProvenanceOntologyService(String entity) throws IOException {
        try {
            URL u = new URL("http://localhost:8080/provse-service/webresources/ontology/?entity=" + entity);
            HttpURLConnection conn = (HttpURLConnection) u.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("GET");
            conn.connect();
            String responseMessage = conn.getResponseMessage();
            InputStream in = conn.getInputStream();
            JSONParser jsonParser = new JSONParser();
            JSONObject jsonObject = (JSONObject) jsonParser.parse(
                    new InputStreamReader(in, "UTF-8"));

            System.out.println(responseMessage);
            return jsonObject;
        } catch (IOException ex) {
            ex.printStackTrace();
            throw ex;
        } catch (ParseException ex) {
            Logger.getLogger(ProvSeOGetInferencesService.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

}
