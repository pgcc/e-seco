package br.ufjf.pgcc.eseco.domain.model.uac;

import javax.persistence.*;

@Entity
@Table(name = "uac_roles")
public class Role {

    @Id
    @Column(name = "id")
    private int id;

    @Column(name = "name", nullable = false)
    private String name;


    /* CONSTRUCTORS */

    public Role() {
    }

    public Role(Integer id, String name) {
        this.id = id;
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

}
