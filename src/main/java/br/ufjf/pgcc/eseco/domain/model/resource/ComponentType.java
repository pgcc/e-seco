package br.ufjf.pgcc.eseco.domain.model.resource;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "res_component_types")
public class ComponentType {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "name")
    private String name;


    /* CONSTRUCTORS */

    public ComponentType() {
    }

    public ComponentType(String name) {
        this.name = name;
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


    /* OTHER METHODS */

    @Override
    public String toString() {
        return "id=" + id + ", name=" + name;
    }
}
