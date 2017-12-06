package br.ufjf.pgcc.eseco.domain.model.resource;

import br.ufjf.pgcc.eseco.domain.model.core.Developer;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "res_workflow_services_ratings_invitations")
public class WorkflowServiceRatingInvitation {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @LazyCollection(LazyCollectionOption.FALSE)
    private WorkflowService workflowService;

    @ManyToOne
    @LazyCollection(LazyCollectionOption.FALSE)
    private Developer asker;

    @ManyToOne
    @LazyCollection(LazyCollectionOption.FALSE)
    private Researcher rater;

    @Column(name = "date_invited")
    private Date dateInvited;

    @Column(name = "date_completed")
    private Date dateCompleted;

    @Column(name = "date_chat")
    private Date dateChat;

    @Column(name = "completed")
    private boolean completed;

    @Column(name = "participated_in_chat")
    private boolean participatedInChat;


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

    public Developer getAsker() {
        return asker;
    }

    public void setAsker(Developer asker) {
        this.asker = asker;
    }

    public Researcher getRater() {
        return rater;
    }

    public void setRater(Researcher rater) {
        this.rater = rater;
    }

    public Date getDateInvited() {
        return dateInvited;
    }

    public void setDateInvited(Date dateInvited) {
        this.dateInvited = dateInvited;
    }

    public Date getDateCompleted() {
        return dateCompleted;
    }

    public void setDateCompleted(Date dateCompleted) {
        this.dateCompleted = dateCompleted;
    }

    public Date getDateChat() {
        return dateChat;
    }

    public void setDateChat(Date dateChat) {
        this.dateChat = dateChat;
    }

    public boolean isCompleted() {
        return completed;
    }

    public void setCompleted(boolean completed) {
        this.completed = completed;
    }

    public boolean isParticipatedInChat() {
        return participatedInChat;
    }

    public void setParticipatedInChat(boolean participatedInChat) {
        this.participatedInChat = participatedInChat;
    }
}
