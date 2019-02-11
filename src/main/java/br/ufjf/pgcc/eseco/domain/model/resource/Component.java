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

    @Column(name = "documentation_url", columnDefinition = "TEXT")
    private String documentationUrl;

    @Column(name = "date_created", columnDefinition = "DATETIME")
    private Date dateCreated;

    @Column(name = "date_updated", columnDefinition = "DATETIME")
    private Date dateUpdated;

    @OneToOne(mappedBy = "component", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private WorkflowService workflowService;

    @OneToOne(mappedBy = "component", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private Plugin plugin;


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

    public String getDocumentationUrl() {
        return documentationUrl;
    }

    public void setDocumentationUrl(String documentationUrl) {
        this.documentationUrl = documentationUrl;
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    public Date getDateUpdated() {
        return dateUpdated;
    }

    public void setDateUpdated(Date dateUpdated) {
        this.dateUpdated = dateUpdated;
    }

    public WorkflowService getWorkflowService() {
        return workflowService;
    }

    public void setWorkflowService(WorkflowService workflowService) {
        this.workflowService = workflowService;
    }

    public Plugin getPlugin() {
        return plugin;
    }

    public void setPlugin(Plugin plugin) {
        this.plugin = plugin;
    }
}
