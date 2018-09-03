package br.ufjf.pgcc.eseco.domain.model.experiment;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import javax.persistence.*;
import java.util.List;

@javax.persistence.Entity
@Table(name = "exp_data_sources_providers")
public class DataSourceProvider {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @LazyCollection(LazyCollectionOption.FALSE)
    private DataSource dataSource;

    @ManyToOne()
    @LazyCollection(LazyCollectionOption.FALSE)
    private DataProvider dataProvider;

    @OneToMany(mappedBy = "dataSourceProvider")
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<DataSourceProviderParameter> parameters;

    public DataSourceProvider() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public DataSource getDataSource() {
        return dataSource;
    }

    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public DataProvider getDataProvider() {
        return dataProvider;
    }

    public void setDataProvider(DataProvider dataProvider) {
        this.dataProvider = dataProvider;
    }

    public List<DataSourceProviderParameter> getParameters() {
        return parameters;
    }

    public void setParameters(List<DataSourceProviderParameter> parameters) {
        this.parameters = parameters;
    }

    @Override
    public String toString() {
        return String.valueOf(id);
    }
}
