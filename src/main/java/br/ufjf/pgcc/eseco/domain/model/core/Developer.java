package br.ufjf.pgcc.eseco.domain.model.core;

import javax.persistence.*;

@Entity
@Table(name = "core_agents_developers")
public class Developer extends Agent {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_institution", nullable = false)
    private Institution institution;


    /* GETTERS/SETTERS */

    public Institution getInstitution() {
        return institution;
    }

    public void setInstitution(Institution institution) {
        this.institution = institution;
    }
}
