package br.ufjf.pgcc.eseco.domain.model.experiment;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import javax.persistence.*;
import java.util.List;

@javax.persistence.Entity
@Table(name = "exp_data_providers")
public class DataProvider {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "name")
    private String name;

    @OneToMany(mappedBy = "dataProvider")
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<DataProviderParameter> parameters;

    public DataProvider() {
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

    public List<DataProviderParameter> getParameters() {
        return parameters;
    }

    public void setParameters(List<DataProviderParameter> parameters) {
        this.parameters = parameters;
    }

    @Override
    public String toString() {
        return String.valueOf(name);
    }
}
