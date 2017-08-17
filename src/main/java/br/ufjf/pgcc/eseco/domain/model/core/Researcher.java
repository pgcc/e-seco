package br.ufjf.pgcc.eseco.domain.model.core;

import javax.persistence.*;

@Entity
@Table(name = "core_agents_researchers")
public class Researcher extends Agent {

    @Column(name = "display_name")
    private String displayName;

    @Column(name = "academic_status")
    private String academicStatus;

    @Column(name = "title")
    private String title;

    @Column(name = "mendeley_id")
    private String mendeleyId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_agent", nullable = false)
    private Agent agent;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_institution", nullable = false)
    private Institution institution;

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

    /* GETTERS/SETTERS */
    public void setMendeleyId(String mendeleyId) {
        this.mendeleyId = mendeleyId;
    }

    public Agent getAgent() {
        return agent;
    }

    public void setAgent(Agent agent) {
        this.agent = agent;
    }

    public Institution getInstitution() {
        return institution;
    }

    public void setInstitution(Institution institution) {
        this.institution = institution;
    }
}
