package br.ufjf.pgcc.eseco.domain.model.core;

import javax.persistence.*;

@Entity
@Table(name = "core_agents_developers")
@PrimaryKeyJoinColumn(name="id_agent")
public class Developer extends Agent {

    /*
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_agent", nullable = false)
    private Agent agent;
    */



    /* GETTERS/SETTERS */


}
