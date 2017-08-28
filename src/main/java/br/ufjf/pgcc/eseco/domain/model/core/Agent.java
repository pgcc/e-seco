package br.ufjf.pgcc.eseco.domain.model.core;

import br.ufjf.pgcc.eseco.domain.model.uac.User;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "core_agents")
public class Agent {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_user", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "id_researcher")
    private Researcher researcher;

    @ManyToOne
    @JoinColumn(name = "id_developer")
    private Developer developer;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "birthday", columnDefinition = "DATETIME")
    private Date birthday;

    @Column(name = "gender", length = 1)
    private String gender;


    /* GETTERS/SETTERS */

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Researcher getResearcher() {
        return researcher;
    }

    public void setResearcher(Researcher researcher) {
        this.researcher = researcher;
    }

    public Developer getDeveloper() {
        return developer;
    }

    public void setDeveloper(Developer developer) {
        this.developer = developer;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }
}
