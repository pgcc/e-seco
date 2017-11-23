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

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @OneToOne(mappedBy = "agent", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private Researcher researcher;

    @OneToOne(mappedBy = "agent", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
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


    /* OTHER METHODS */
    public String getPhoto(){
        String photo = null;

        // Search for researcher photo
        if(null != getResearcher()){
            if(null != getResearcher().getPhoto()){
                photo = getResearcher().getPhoto();
            }
        }

        // Search for developer photo
        if(null == photo){
            if(null != getDeveloper()){
                if(null != getDeveloper().getPhoto()){
                    photo = getDeveloper().getPhoto();
                }
            }
        }

        // If none, use generic empty photo
        if(null == photo){
            photo = "empty.png";
        }

        return photo;
    }
}
