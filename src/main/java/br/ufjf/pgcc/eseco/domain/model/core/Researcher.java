package br.ufjf.pgcc.eseco.domain.model.core;

import javax.persistence.*;

@Entity
@Table(name = "core_agents_researchers")
public class Researcher extends Agent {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_agent", nullable = false)
    private Agent agent;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_institution", nullable = false)
    private Institution institution;


    /* GETTERS/SETTERS */

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
