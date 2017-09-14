package br.ufjf.pgcc.eseco.domain.model.resource;

import javax.persistence.*;

@Entity
@Table(name = "res_services_workflow")
public class ServiceWorkflow {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "component_id", nullable = false)
    private Component component;

    @Column(name = "protocol")
    private String protocol;


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

    public String getProtocol() {
        return protocol;
    }

    public void setProtocol(String protocol) {
        this.protocol = protocol;
    }

}
