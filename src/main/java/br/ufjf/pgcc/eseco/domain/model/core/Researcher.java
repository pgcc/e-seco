package br.ufjf.pgcc.eseco.domain.model.core;

import javax.persistence.*;

@Entity
@Table(name = "core_agents_researchers")
@PrimaryKeyJoinColumn(name="id_agent")
public class Researcher extends Agent {

    /*
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_agent", nullable = false)
    @Column(name = "id_agent")
    private Agent agent;
    */

    @Column(name = "display_name")
    private String displayName;

    @Column(name = "academic_status")
    private String academicStatus;

    @Column(name = "title")
    private String title;

    @Column(name = "mendeley_id")
    private String mendeleyId;



    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_institution", nullable = false)
    private Institution institution;


    /* GETTERS/SETTERS */

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


    public Institution getInstitution() {
        return institution;
    }

    public void setInstitution(Institution institution) {
        this.institution = institution;
    }
}
