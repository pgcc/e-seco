package br.ufjf.pgcc.eseco.domain.model.experiment;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import javax.persistence.*;

@javax.persistence.Entity
@Table(name = "exp_data_providers_parameters")
public class DataProviderParameter {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "name")
    private String name;

    @ManyToOne
    @LazyCollection(LazyCollectionOption.FALSE)
    private DataProvider dataProvider;

    public DataProviderParameter() {
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

    @Override
    public String toString() {
        return String.valueOf(name);
    }
}
