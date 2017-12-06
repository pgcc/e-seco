package br.ufjf.pgcc.eseco.domain.model.resource;

import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "res_workflow_services_ratings")
public class WorkflowServiceRating {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private WorkflowService workflowService;

    @Column(name = "date")
    private Date date;

    @ManyToOne
    @JoinColumn(name = "rater_id", nullable = false)
    private Researcher rater;

    @Column(name = "approved")
    private boolean approved;

    @Column(name = "reproved_text", columnDefinition="TEXT")
    private String reprovedText;

    @Column(name = "value_documentation")
    private int valueDocumentation;

    @Column(name = "value_ease_of_use")
    private int valueEaseOfUse;

    @Column(name = "value_reliability")
    private int valueReliability;

    @Column(name = "value_performance")
    private int valuePerformance;

    @Column(name = "value_disponibility")
    private int valueDisponibility;


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

    public Researcher getRater() {
        return rater;
    }

    public void setRater(Researcher rater) {
        this.rater = rater;
    }

    public int getValueDocumentation() {
        return valueDocumentation;
    }

    public void setValueDocumentation(int valueDocumentation) {
        this.valueDocumentation = valueDocumentation;
    }

    public int getValueEaseOfUse() {
        return valueEaseOfUse;
    }

    public void setValueEaseOfUse(int valueEaseOfUse) {
        this.valueEaseOfUse = valueEaseOfUse;
    }

    public int getValueReliability() {
        return valueReliability;
    }

    public void setValueReliability(int valueReliability) {
        this.valueReliability = valueReliability;
    }

    public int getValuePerformance() {
        return valuePerformance;
    }

    public void setValuePerformance(int valuePerformance) {
        this.valuePerformance = valuePerformance;
    }

    public int getValueDisponibility() {
        return valueDisponibility;
    }

    public void setValueDisponibility(int valueDisponibility) {
        this.valueDisponibility = valueDisponibility;
    }

    public boolean isApproved() {
        return approved;
    }

    public void setApproved(boolean approved) {
        this.approved = approved;
    }

    public String getReprovedText() {
        return reprovedText;
    }

    public void setReprovedText(String reprovedText) {
        this.reprovedText = reprovedText;
    }
}
