package br.ufjf.pgcc.eseco.domain.model.core;

import javax.persistence.*;

@Entity
@Table(name = "core_institutions")
public class Institution {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "name", nullable = false)
    private String name;

    @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinColumn(name = "city_id")
    private City city;

//    private List<String> alternative_names;
//
//    private List<String> urls;

    /* GETTERS/SETTERS */
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

    public City getCity() {
        return city;
    }

    public void setCity(City city) {
        this.city = city;
    }

    public boolean isNew() {
        return (this.id == 0);
    }

    @Override
    public String toString() {
        return String.valueOf(id);
    }

}
