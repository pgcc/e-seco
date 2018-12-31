package br.ufjf.pgcc.eseco.scientificDomain.model.eseco.biology;

import javax.persistence.*;

@Entity
@Table(name = "sm_eseco_biology_specimen_collection_types")
public class SpecimenCollectionType {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "name", nullable = false)
    private String name;


    /* GETTERS AND SETTERS */

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

}
