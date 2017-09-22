/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.domain.model.experiment;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 *
 * @author Lenita
 */
@Entity
@Table(name = "exp_ports")
public class Port {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "entity_id", nullable = false)
    private br.ufjf.pgcc.eseco.domain.model.experiment.Entity entity;

    public Port() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public br.ufjf.pgcc.eseco.domain.model.experiment.Entity getEntity() {
        return entity;
    }

    public void setEntity(br.ufjf.pgcc.eseco.domain.model.experiment.Entity entity) {
        this.entity = entity;
    }

}
