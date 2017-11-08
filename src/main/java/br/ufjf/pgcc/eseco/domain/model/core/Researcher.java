package br.ufjf.pgcc.eseco.domain.model.core;

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

    @Column(name = "display_name")
    private String displayName;

    @Column(name = "academic_status")
    private String academicStatus;

    @Column(name = "title")
    private String title;

    @Column(name = "mendeley_id")
    private String mendeleyId;

    @Column(name = "kepler_id")
    private String keplerId;

    @OneToOne(fetch = FetchType.EAGER)
    private Agent agent;

    @OneToMany(cascade = CascadeType.ALL)
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


    /* GETTERS/SETTERS */
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDisplayName() {
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

    public Agent getAgent() {
        return agent;
    }

    public void setAgent(Agent agent) {
        this.agent = agent;
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
}
