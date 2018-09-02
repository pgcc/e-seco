package br.ufjf.pgcc.eseco.domain.model.experiment;

import br.ufjf.pgcc.eseco.domain.model.core.Researcher;

import javax.persistence.*;

@javax.persistence.Entity
@Table(name = "exp_data_source") //nome da tabela a ser criada
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

    @Transient
    private SourceName sourceName;

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

    public void setSourceName(SourceName sourceName) {
        this.sourceName = sourceName;
    }

    public boolean isNew() {
        return (this.id == 0);
    }

    @Override
    public String toString() {
        return String.valueOf(id);
    }
}
