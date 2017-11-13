/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.domain.model.experiment;

import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 *
 * @author Lenita
 */
@javax.persistence.Entity
@Table(name = "exp_entities")
public class Entity {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "name")
    private String name;

    @ManyToOne
    @JoinColumn(name = "author_id")
    private Researcher author;

    @Transient
    private EntityKind kind;

    @OneToOne(mappedBy = "entity", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private Data data;

    @OneToOne(mappedBy = "entity", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private Document document;

    public Entity() {
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

    public Researcher getAuthor() {
        return author;
    }

    public void setAuthor(Researcher author) {
        this.author = author;
    }

    public EntityKind getKind() {
        if (kind == null) {
            if (this.getData() != null && this.getDocument() == null) {
                kind = EntityKind.DATA;
            }
            if (this.getDocument() != null && this.getData() == null) {
                kind = EntityKind.DOCUMENT;
            }
        }
        return kind;
    }

    public void setKind(EntityKind kind) {
        this.kind = kind;
    }

    public Data getData() {
        return data;
    }

    public void setData(Data data) {
        this.data = data;
    }

    public Document getDocument() {
        return document;
    }

    public void setDocument(Document document) {
        this.document = document;
    }

    public boolean isNew() {
        return (this.id == 0);
    }

    @Override
    public String toString() {
        return String.valueOf(id);
    }
}
