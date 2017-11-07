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
@Table(name = "core_research_groups")
public class ResearchGroup {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "name")
    private String name;

    @Column(name = "description")
    private String description;

    @Column(name = "web_page")
    private String webPage;

    @OneToMany
    @JoinTable(
            name = "core_research_group_researcher",
            joinColumns = {
                @JoinColumn(name = "research_group_id", nullable = false)
            },
            inverseJoinColumns = {
                @JoinColumn(name = "researcher_id", nullable = false)
            }
    )
    private List<Researcher> members;

    public ResearchGroup(String name, String description, String webPage, List<Researcher> members) {
        this.name = name;
        this.description = description;
        this.webPage = webPage;
        this.members = members;
    }

    public ResearchGroup() {
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getWebPage() {
        return webPage;
    }

    public void setWebPage(String webPage) {
        this.webPage = webPage;
    }

    public List<Researcher> getMembers() {
        return members;
    }

    public void setMembers(List<Researcher> members) {
        this.members = members;
    }

    public boolean isNew() {
        return (this.id == 0);
    }
}
