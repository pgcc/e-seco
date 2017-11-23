package br.ufjf.pgcc.eseco.domain.model.core;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "core_agents_developers")
public class Developer {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private Agent agent;

    @OneToMany
    @JoinTable(
            name = "core_agents_developers_institutions",
            joinColumns = {
                    @JoinColumn(name = "developer_id", nullable = false)
            },
            inverseJoinColumns = {
                    @JoinColumn(name = "institution_id", nullable = false)
            }
    )
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<Institution> institutions;

    @Column(name = "photo")
    private String photo;


    /* GETTERS/SETTERS */

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }
}
