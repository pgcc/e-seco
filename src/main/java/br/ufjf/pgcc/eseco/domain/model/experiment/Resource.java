package br.ufjf.pgcc.eseco.domain.model.experiment;

import javax.persistence.*;

@Entity
@Table(name = "exp_resources")
public class Resource {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_type", nullable = false)
    private ResourceType type;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_origin", nullable = false)
    private ResourceOrigin origin;

    @Column(name = "name")
    private String name;

    @Column(name = "description")
    private String description;

    @Column(name = "class_name")
    private String className;


    /* GETTERS/SETTERS */

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public ResourceType getType() {
        return type;
    }

    public void setType(ResourceType type) {
        this.type = type;
    }

    public ResourceOrigin getOrigin() {
        return origin;
    }

    public void setOrigin(ResourceOrigin origin) {
        this.origin = origin;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }


    /* OTHER METHODS */

    @Override
    public String toString() {
        return "id=" + id + ", name=" + name;
    }
}
