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

    @OneToOne(fetch = FetchType.EAGER)
    private Agent agent;

    @OneToMany
    @JoinTable(
            name = "core_agents_researchers_institutions",
            joinColumns = {
                    @JoinColumn(name = "id_researcher", nullable = false)
            },
            inverseJoinColumns = {
                    @JoinColumn(name = "id_institution", nullable = false)
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
}
