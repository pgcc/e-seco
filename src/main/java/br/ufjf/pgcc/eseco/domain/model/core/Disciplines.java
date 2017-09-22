/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.domain.model.core;

import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 *
 * @author Lenita
 */
@Entity
@Table(name = "core_disciplines")
public class Disciplines {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "name")
    private String name;

    @OneToMany
    @JoinTable(
            name = "core_discipline_subdiscipline",
            joinColumns = {
                @JoinColumn(name = "discipline_id", nullable = false)
            },
            inverseJoinColumns = {
                @JoinColumn(name = "subdiscipline_id", nullable = false)
            }
    )
    private List<Disciplines> subdisciplines;

    public Disciplines() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<Disciplines> getSubdisciplines() {
        return subdisciplines;
    }

    public void setSubdisciplines(List<Disciplines> subdisciplines) {
        this.subdisciplines = subdisciplines;
    }

}
