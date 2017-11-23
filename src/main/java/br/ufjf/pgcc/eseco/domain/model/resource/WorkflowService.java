package br.ufjf.pgcc.eseco.domain.model.resource;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "res_workflow_services")
public class WorkflowService {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private Component component;

    @Column(name = "type")
    private String type;

    @Column(name = "nature")
    private String nature;

    @Column(name = "url")
    private String url;

    @Column(name = "description")
    private String description;

    @Column(name = "internal_class", unique = true)
    private String internalClass;

    @OneToMany(cascade = CascadeType.ALL)
    @LazyCollection(LazyCollectionOption.FALSE)
    @JoinTable(
            name = "res_workflow_services_ratings",
            joinColumns = {
                    @JoinColumn(name = "workflowService_id", nullable = false)
            },
            inverseJoinColumns = {
                    @JoinColumn(name = "id")
            }
    )
    private List<WorkflowServiceRating> workflowServiceRatingList;

    @OneToMany(mappedBy = "workflowService")
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<WorkflowServiceRatingInvitation> workflowServiceRatingInvitations;

    @OneToMany(mappedBy = "workflowService")
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<WorkflowServiceComment> workflowServiceComments;


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

    public String getNature() {
        return nature;
    }

    public void setNature(String nature) {
        this.nature = nature;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getInternalClass() {
        return internalClass;
    }

    public void setInternalClass(String internalClass) {
        this.internalClass = internalClass;
    }

    public List<WorkflowServiceRating> getWorkflowServiceRatingList() {
        return workflowServiceRatingList;
    }

    public void setWorkflowServiceRatingList(List<WorkflowServiceRating> workflowServiceRatingList) {
        this.workflowServiceRatingList = workflowServiceRatingList;
    }

    public List<WorkflowServiceRatingInvitation> getWorkflowServiceRatingInvitations() {
        return workflowServiceRatingInvitations;
    }

    public void setWorkflowServiceRatingInvitations(List<WorkflowServiceRatingInvitation> workflowServiceRatingInvitations) {
        this.workflowServiceRatingInvitations = workflowServiceRatingInvitations;
    }

    public List<WorkflowServiceComment> getWorkflowServiceComments() {
        return workflowServiceComments;
    }

    public void setWorkflowServiceComments(List<WorkflowServiceComment> workflowServiceComments) {
        this.workflowServiceComments = workflowServiceComments;
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
