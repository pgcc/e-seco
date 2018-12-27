package br.ufjf.pgcc.eseco.domain.model.experiment;

import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@javax.persistence.Entity
@Table(name = "exp_data_sources")
public class DataSource {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "name")
    private String name;

    @ManyToOne
    @JoinColumn(name = "author_id")
    private Researcher author;

    @Column(name = "date_created", columnDefinition = "DATETIME")
    private Date dateCreated;

    @Column(name = "date_updated", columnDefinition = "DATETIME")
    private Date dateUpdated;

    @OneToMany(mappedBy = "dataSource")
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<DataSourceProvider> providers;

    public DataSource() {
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

    public Researcher getAuthor() {
        return author;
    }

    public void setAuthor(Researcher author) {
        this.author = author;
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    public Date getDateUpdated() {
        return dateUpdated;
    }

    public void setDateUpdated(Date dateUpdated) {
        this.dateUpdated = dateUpdated;
    }

    public List<DataSourceProvider> getProviders() {
        return providers;
    }

    public void setProviders(List<DataSourceProvider> providers) {
        this.providers = providers;
    }

    @Override
    public String toString() {
        return String.valueOf(id);
    }
}
