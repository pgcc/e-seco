package br.ufjf.pgcc.eseco.app.model;

import java.util.List;

public class MendeleyCatalog {

    private String title;
    private String year;
    private List<String> keywords;


    /* GETTERS/SETTERS */

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public List<String> getKeywords() {
        return keywords;
    }

    public void setKeywords(List<String> keywords) {
        this.keywords = keywords;
    }
}
