package br.ufjf.pgcc.eseco.domain.model.resource;

import br.ufjf.pgcc.eseco.domain.model.core.Developer;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "res_components")
public class Component {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "type_id", nullable = false)
    private ComponentType type;

    @OneToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name = "res_component_developers",
            joinColumns = {
                    @JoinColumn(name = "component_id", nullable = false)
            },
            inverseJoinColumns = {
                    @JoinColumn(name = "developer_id", nullable = false)
            }
    )
    private List<Developer> developers;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "author_id", nullable = false)
    private Developer author;

    @Column(name = "name")
    private String name;

    @Column(name = "description")
    private String description;

    @Column(name = "date_created", columnDefinition = "DATETIME")
    private Date dateCreated;

    @OneToOne(mappedBy = "component", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private ServiceWorkflow serviceWorkflow;


    /* GETTERS/SETTERS */

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public ComponentType getType() {
        return type;
    }

    public void setType(ComponentType type) {
        this.type = type;
    }

    public List<Developer> getDevelopers() {
        return developers;
    }

    public void setDevelopers(List<Developer> developers) {
        this.developers = developers;
    }

    public Developer getAuthor() {
        return author;
    }

    public void setAuthor(Developer author) {
        this.author = author;
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

    public Date getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    public ServiceWorkflow getServiceWorkflow() {
        return serviceWorkflow;
    }

    public void setServiceWorkflow(ServiceWorkflow serviceWorkflow) {
        this.serviceWorkflow = serviceWorkflow;
    }
}
