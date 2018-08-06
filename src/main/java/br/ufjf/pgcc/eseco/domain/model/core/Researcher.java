package br.ufjf.pgcc.eseco.domain.model.core;

import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowServiceRatingInvitation;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "core_agents_researchers")
public class Researcher {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @OneToOne(fetch = FetchType.EAGER)
    private Agent agent;

    @Column(name = "display_name")
    private String displayName;

    @Column(name = "academic_status")
    private String academicStatus;

    @Column(name = "title")
    private String title;

    @Column(name = "mendeley_id")
    private String mendeleyId;

    @Column(name = "researchgate_id")
    private String researchgateId;
    
    @Column(name = "kepler_id")
    private String keplerId;
    
    @Column(name = "lattes_id")
    private String lattesId;

    @Column(name = "photo")
    private String photo;

    @ManyToMany
    @LazyCollection(LazyCollectionOption.FALSE)
    @JoinTable(
            name = "core_agents_researchers_interests",
            joinColumns = {
                @JoinColumn(name = "researcher_id", referencedColumnName = "id", nullable = false)
            },
            inverseJoinColumns = {
                @JoinColumn(name = "interest_id", referencedColumnName = "id", nullable = false)
            }
    )
    private List<Interest> researchInterests;

    @ManyToMany
    @LazyCollection(LazyCollectionOption.FALSE)
    @JoinTable(
            name = "core_agents_researchers_disciplines",
            joinColumns = {
                @JoinColumn(name = "researcher_id", referencedColumnName = "id", nullable = false)
            },
            inverseJoinColumns = {
                @JoinColumn(name = "discipline_id", referencedColumnName = "id", nullable = false)
            }
    )
    private List<Discipline> disciplines;

    @ManyToMany
    @JoinTable(
            name = "core_agents_researchers_institutions",
            joinColumns = {
                @JoinColumn(name = "researcher_id", referencedColumnName = "id", nullable = false)
            },
            inverseJoinColumns = {
                @JoinColumn(name = "institution_id", referencedColumnName = "id", nullable = false)
            }
    )
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<Institution> institutions;

    @OneToMany(mappedBy = "rater")
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<WorkflowServiceRatingInvitation> workflowServiceRatingInvitations;

    @OneToMany(mappedBy = "researcher")
    @LazyCollection(LazyCollectionOption.FALSE)
    @OrderBy("year, name")
    private List<ResearcherKeyword> researchKeywords;


    /* GETTERS/SETTERS */
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Agent getAgent() {
        return agent;
    }

    public void setAgent(Agent agent) {
        this.agent = agent;
    }

    public String getDisplayName() {
        if (agent != null && agent.getName() != null) {
            return agent.getName();
        }
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getAcademicStatus() {
        return academicStatus;
    }

    public void setAcademicStatus(String academicStatus) {
        this.academicStatus = academicStatus;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getMendeleyId() {
        return mendeleyId;
    }

    public void setMendeleyId(String mendeleyId) {
        this.mendeleyId = mendeleyId;
    }

    public String getKeplerId() {
        return keplerId;
    }

    public void setKeplerId(String keplerId) {
        this.keplerId = keplerId;
    }

    public String getPhoto() {
        if(photo == null || photo.isEmpty()){
            photo = "resources/images/agent-photo-blank.png";
        }
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public List<Interest> getResearchInterests() {
        return researchInterests;
    }

    public void setResearchInterests(List<Interest> researchInterests) {
        this.researchInterests = researchInterests;
    }

    public List<Discipline> getDisciplines() {
        return disciplines;
    }

    public void setDisciplines(List<Discipline> disciplines) {
        this.disciplines = disciplines;
    }

    public List<Institution> getInstitutions() {
        return institutions;
    }

    public void setInstitutions(List<Institution> institutions) {
        this.institutions = institutions;
    }

    public boolean isNew() {
        return (this.id == 0);
    }

    @Override
    public String toString() {
        return String.valueOf(id);
    }

    public List<WorkflowServiceRatingInvitation> getWorkflowServiceRatingInvitations() {
        return workflowServiceRatingInvitations;
    }

    public void setWorkflowServiceRatingInvitations(List<WorkflowServiceRatingInvitation> workflowServiceRatingInvitations) {
        this.workflowServiceRatingInvitations = workflowServiceRatingInvitations;
    }

    public List<ResearcherKeyword> getResearchKeywords() {
        return researchKeywords;
    }

    public void setResearchKeywords(List<ResearcherKeyword> researchKeywords) {
        this.researchKeywords = researchKeywords;
    }

    public String getResearchgateId() {
        return researchgateId;
    }

    public void setResearchgateId(String researchgateId) {
        this.researchgateId = researchgateId;
    }

    public String getLattesId() {
        return lattesId;
    }

    public void setLattesId(String lattesId) {
        this.lattesId = lattesId;
    }
    
    
}
