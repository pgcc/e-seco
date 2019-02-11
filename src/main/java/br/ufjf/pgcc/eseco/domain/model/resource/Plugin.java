package br.ufjf.pgcc.eseco.domain.model.resource;

import javax.persistence.*;

@Entity
@Table(name = "res_plugins")
public class Plugin {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private Component component;

    @Column(name = "internal_class", unique = true)
    private String internalClass;


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

    public String getInternalClass() {
        return internalClass;
    }

    public void setInternalClass(String internalClass) {
        this.internalClass = internalClass;
    }
}
