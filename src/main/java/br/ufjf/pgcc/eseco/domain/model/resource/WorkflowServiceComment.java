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

    @Column(name = "content", columnDefinition = "TEXT")
    private String content;

    @ManyToOne
    @LazyCollection(LazyCollectionOption.FALSE)
    private WorkflowServiceComment parent;

    @OneToMany(mappedBy = "parent")
    @LazyCollection(LazyCollectionOption.FALSE)
    @OrderBy("date DESC")
    private List<WorkflowServiceComment> responses;

    @Column(name = "rate_star_1")
    private Integer rateStar1;

    @Column(name = "rate_star_2")
    private Integer rateStar2;

    @Column(name = "rate_star_3")
    private Integer rateStar3;

    @Column(name = "rate_star_4")
    private Integer rateStar4;

    @Column(name = "rate_star_5")
    private Integer rateStar5;


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

    public int getRateStar1() {
        return rateStar1;
    }

    public void setRateStar1(int rateStar1) {
        this.rateStar1 = rateStar1;
    }

    public int getRateStar2() {
        return rateStar2;
    }

    public void setRateStar2(int rateStar2) {
        this.rateStar2 = rateStar2;
    }

    public int getRateStar3() {
        return rateStar3;
    }

    public void setRateStar3(int rateStar3) {
        this.rateStar3 = rateStar3;
    }

    public int getRateStar4() {
        return rateStar4;
    }

    public void setRateStar4(int rateStar4) {
        this.rateStar4 = rateStar4;
    }

    public int getRateStar5() {
        return rateStar5;
    }

    public void setRateStar5(int rateStar5) {
        this.rateStar5 = rateStar5;
    }


    /* OTHER METHODS */

    /**
     *
     * @return Total stars ratings
     */
    public long getRateStarsTotal(){
        int s1 = rateStar1 != null ? rateStar1 : 0;
        int s2 = rateStar2 != null ? rateStar2 : 0;
        int s3 = rateStar3 != null ? rateStar3 : 0;
        int s4 = rateStar4 != null ? rateStar4 : 0;
        int s5 = rateStar5 != null ? rateStar5 : 0;

        return s1 + s2 + s3 + s4 + s5;
    }

    /**
     *
     * @return Average stars ratings
     */
    public Long getRateStarsAverage() {

        int s1 = rateStar1 != null ? rateStar1 : 0;
        int s2 = rateStar2 != null ? rateStar2 : 0;
        int s3 = rateStar3 != null ? rateStar3 : 0;
        int s4 = rateStar4 != null ? rateStar4 : 0;
        int s5 = rateStar5 != null ? rateStar5 : 0;

        double weightedAverage = (s1) + (s2 * 2) + (s3 * 3) + (s4 * 4) + (s5 * 5);
        weightedAverage /= s1 + s2 + s3 + s4 + s5;

        return Math.round(weightedAverage);
    }
}
