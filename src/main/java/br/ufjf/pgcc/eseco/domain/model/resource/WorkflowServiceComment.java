package br.ufjf.pgcc.eseco.domain.model.resource;

import br.ufjf.pgcc.eseco.domain.model.core.Agent;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "res_workflow_services_comments")
public class WorkflowServiceComment {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @LazyCollection(LazyCollectionOption.FALSE)
    private WorkflowService workflowService;

    @Column(name = "date")
    private Date date;

    @ManyToOne
    @JoinColumn(name = "commenter_id", nullable = false)
    private Agent commenter;

    @Column(name = "content", columnDefinition="TEXT")
    private String content;

    @ManyToOne
    @LazyCollection(LazyCollectionOption.FALSE)
    private WorkflowServiceComment parent;

    @OneToMany(mappedBy="parent")
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<WorkflowServiceComment> responses;


    /* GETTERS/SETTERS */

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public WorkflowService getWorkflowService() {
        return workflowService;
    }

    public void setWorkflowService(WorkflowService workflowService) {
        this.workflowService = workflowService;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Agent getCommenter() {
        return commenter;
    }

    public void setCommenter(Agent commenter) {
        this.commenter = commenter;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public WorkflowServiceComment getParent() {
        return parent;
    }

    public void setParent(WorkflowServiceComment parent) {
        this.parent = parent;
    }

    public List<WorkflowServiceComment> getResponses() {
        return responses;
    }

    public void setResponses(List<WorkflowServiceComment> responses) {
        this.responses = responses;
    }
}
