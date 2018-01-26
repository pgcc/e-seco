package br.ufjf.pgcc.eseco.scientificModels.agriculture;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "sm_agriculture_experiments")
public class BovineExperiment {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "description")
    private String description;

    @Column(name = "startDate", columnDefinition = "DATETIME")
    private Date startDate;

    @Column(name = "endDate", columnDefinition = "DATETIME")
    private Date endDate;

    @OneToMany(cascade = CascadeType.ALL)
    @LazyCollection(LazyCollectionOption.FALSE)
    @JoinTable(
            name = "sm_agriculture_experiment_animals",
            joinColumns = {
                    @JoinColumn(name = "experiment_id", nullable = false)
            },
            inverseJoinColumns = {
                    @JoinColumn(name = "id")
            }
    )
    private List<ExperimentAnimal> experimentAnimals;


    /* GETTERS AND SETTERS */

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public List<ExperimentAnimal> getExperimentAnimals() {
        return experimentAnimals;
    }

    public void setExperimentAnimals(List<ExperimentAnimal> experimentAnimals) {
        this.experimentAnimals = experimentAnimals;
    }
}
