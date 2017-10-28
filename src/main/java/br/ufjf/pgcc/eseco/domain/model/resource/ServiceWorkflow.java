package br.ufjf.pgcc.eseco.domain.model.resource;

import javax.persistence.*;

@Entity
@Table(name = "res_services_workflow")
public class ServiceWorkflow {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private Component component;

    @Column(name = "type")
    private String type;

    @Column(name = "description")
    private String description;


    /* GETTERS/SETTERS */

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Component getComponent() {
        return component;
    }

    public void setComponent(Component component) {
        this.component = component;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }


    /* OTHER METHODS */

    public String getShortDescription() {
        if (description != null && description.length() > 100) {
            return description.substring(0, 100) + "...";
        } else {
            return description;
        }
    }
}
