package br.ufjf.pgcc.eseco.scientificDomain.model.eseco.biology;

public class Specimen {

    private String scientificName;
    private String classificationOrder;
    private String classificationFamily;
    private String classificationGenus;


    /* GETTERS AND SETTERS */

    public String getScientificName() {
        return scientificName;
    }

    public void setScientificName(String scientificName) {
        this.scientificName = scientificName;
    }

    public String getClassificationOrder() {
        return classificationOrder;
    }

    public void setClassificationOrder(String classificationOrder) {
        this.classificationOrder = classificationOrder;
    }

    public String getClassificationFamily() {
        return classificationFamily;
    }

    public void setClassificationFamily(String classificationFamily) {
        this.classificationFamily = classificationFamily;
    }

    public String getClassificationGenus() {
        return classificationGenus;
    }

    public void setClassificationGenus(String classificationGenus) {
        this.classificationGenus = classificationGenus;
    }

}
