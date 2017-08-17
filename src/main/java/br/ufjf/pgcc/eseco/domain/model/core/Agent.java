package br.ufjf.pgcc.eseco.domain.model.core;

import br.ufjf.pgcc.eseco.domain.model.uac.User;

import javax.persistence.*;
import java.util.Date;


@Entity
@Table(name = "core_agents")
@Inheritance(strategy = InheritanceType.JOINED)
public abstract class Agent {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_user", nullable = false)
    private User user;

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
