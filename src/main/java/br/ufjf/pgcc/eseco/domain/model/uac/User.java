package br.ufjf.pgcc.eseco.domain.model.uac;

import br.ufjf.pgcc.eseco.domain.model.core.Agent;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "uac_users")
public class User {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "email", nullable = false, unique = true)
    private String email;

    @Column(name = "login", nullable = false, unique = true)
    private String login;

    @Column(name = "password")
    private String password;

    @Column(name = "active", nullable = false)
    private Boolean active;

    @Column(name = "activation_code")
    private String activationCode;

    @Column(name = "activation_expire_date", columnDefinition = "DATETIME")
    private Date activationExpireDate;

    @Column(name = "register_date", columnDefinition = "DATETIME")
    private Date registerDate;

    @Column(name = "redefinition_code")
    private String redefinitionCode;

    @Column(name = "redefinition_expire_date", columnDefinition = "DATETIME")
    private Date redefinitionExpireDate;

    @OneToOne(fetch = FetchType.EAGER)
    private Agent agent;

    @OneToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name = "uac_users_roles",
            joinColumns = {
                    @JoinColumn(name = "id_user", nullable = false)
            },
            inverseJoinColumns = {
                    @JoinColumn(name = "id_role", nullable = false)
            }
    )
    private List<Role> roles;


    /* GETTERS/SETTERS */

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public String getActivationCode() {
        return activationCode;
    }

    public void setActivationCode(String activationCode) {
        this.activationCode = activationCode;
    }

    public Date getActivationExpireDate() {
        return activationExpireDate;
    }

    public void setActivationExpireDate(Date activationExpireDate) {
        this.activationExpireDate = activationExpireDate;
    }

    public Date getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(Date registerDate) {
        this.registerDate = registerDate;
    }

    public String getRedefinitionCode() {
        return redefinitionCode;
    }

    public void setRedefinitionCode(String redefinitionCode) {
        this.redefinitionCode = redefinitionCode;
    }

    public Date getRedefinitionExpireDate() {
        return redefinitionExpireDate;
    }

    public void setRedefinitionExpireDate(Date redefinitionExpireDate) {
        this.redefinitionExpireDate = redefinitionExpireDate;
    }

    public Agent getAgent() {
        return agent;
    }

    public void setAgent(Agent agent) {
        this.agent = agent;
    }

    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }

}
