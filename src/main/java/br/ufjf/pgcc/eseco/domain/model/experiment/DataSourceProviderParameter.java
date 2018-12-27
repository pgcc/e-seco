package br.ufjf.pgcc.eseco.domain.model.experiment;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import javax.persistence.*;

@javax.persistence.Entity
@Table(name = "exp_data_sources_providers_parameters")
public class DataSourceProviderParameter {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne()
    @LazyCollection(LazyCollectionOption.FALSE)
    private DataSourceProvider dataSourceProvider;

    @ManyToOne()
    @LazyCollection(LazyCollectionOption.FALSE)
    private DataProviderParameter dataProviderParameter;

    @Column(name = "value_string")
    private String valueString;

    public DataSourceProviderParameter() {
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public DataSourceProvider getDataSourceProvider() {
        return dataSourceProvider;
    }

    public void setDataSourceProvider(DataSourceProvider dataSourceProvider) {
        this.dataSourceProvider = dataSourceProvider;
    }

    public DataProviderParameter getDataProviderParameter() {
        return dataProviderParameter;
    }

    public void setDataProviderParameter(DataProviderParameter dataProviderParameter) {
        this.dataProviderParameter = dataProviderParameter;
    }

    public String getValueString() {
        return valueString;
    }

    public void setValueString(String valueString) {
        this.valueString = valueString;
    }

    @Override
    public String toString() {
        return String.valueOf(id);
    }
}
