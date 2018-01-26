package br.ufjf.pgcc.eseco.app.model;

import com.google.gson.JsonObject;

import java.util.ArrayList;

public class ApiRestResult {

    private String data;
    private JsonObject jsonData;
    private ArrayList<String> _links;
    private String error;


    /* GETTERS/SETTERS */

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public JsonObject getJsonData() {
        return jsonData;
    }

    public void setJsonData(JsonObject jsonData) {
        this.jsonData = jsonData;
    }

    public ArrayList<String> get_links() {
        return _links;
    }

    public void set_links(ArrayList<String> _links) {
        this._links = _links;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }
}
