/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.app.service;

import com.google.gson.JsonObject;
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

    public void testURL(String path) throws IOException {
        try {
            URL u = new URL("http://" + path + "/provse-service/rest/ontology/");

            HttpURLConnection urlConn = (HttpURLConnection) u.openConnection();
            urlConn.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:25.0) Gecko/20100101 Firefox/25.0");
            urlConn.connect();
//            assertEquals(HttpURLConnection.HTTP_OK, urlConn.getResponseCode());
        } catch (IOException e) {
            System.err.println("Error creating HTTP connection");
            e.printStackTrace();
            throw e;
        }
    }

    public void callOntologyService(String path, JsonObject rawData) throws IOException {
        try {
            String type = "application/json";
            byte[] encodedData = rawData.toString().getBytes(StandardCharsets.UTF_8);
            URL u = new URL("http://" + path + "/provse-service/rest/ontology/");
            HttpURLConnection conn = (HttpURLConnection) u.openConnection();
            conn.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:25.0) Gecko/20100101 Firefox/25.0");
            conn.setDoOutput(true);
            conn.setRequestMethod("PUT");
            conn.setRequestProperty("Content-Type", type);
            conn.setRequestProperty("Content-Length", String.valueOf(encodedData.length));
            OutputStream os = conn.getOutputStream();
            os.write(encodedData);
            conn.connect();
            if (conn.getResponseCode() != HttpStatus.OK.value()) {
                throw new HTTPException(conn.getResponseCode());
            }
        } catch (IOException ex) {
            ex.printStackTrace();
            throw ex;
        }
    }

    public JSONObject getProvenanceOntologyService(String path, String entity) throws IOException {
        try {
            URL u = new URL("http://" + path + "/provse-service/rest/ontology/?entity=" + entity);
            HttpURLConnection conn = (HttpURLConnection) u.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("GET");
            conn.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:25.0) Gecko/20100101 Firefox/25.0");
            conn.connect();
            String responseMessage = conn.getResponseMessage();
            InputStream in = conn.getInputStream();
            JSONParser jsonParser = new JSONParser();
            JSONObject jsonObject = (JSONObject) jsonParser.parse(
                    new InputStreamReader(in, "UTF-8"));

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
