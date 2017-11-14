package br.ufjf.pgcc.eseco.domain.model.analysis;

public class ReseacherRelevance {

    private int id;
    private String name;
    private double relevance;


    /* CONSTRUCTORS */

    public ReseacherRelevance() {

    }


    /* GETTERS/SETTERS */

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getRelevance() {
        return relevance;
    }

    public void setRelevance(double relevance) {
        this.relevance = relevance;
    }
}
