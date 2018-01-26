package br.ufjf.pgcc.eseco.scientificModels.agriculture;


import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "sm_agriculture_experiment_animals")
public class ExperimentAnimal {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private Experiment experiment;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private Animal animal;

    @ManyToMany
    @LazyCollection(LazyCollectionOption.FALSE)
    @JoinTable(
            name = "sm_agriculture_experiment_animals_meals",
            joinColumns = {
                    @JoinColumn(name = "experiment_id", nullable = false)
            },
            inverseJoinColumns = {
                    @JoinColumn(name = "meal_id", nullable = false)
            }
    )
    private List<Meal> meals;



    /* GETTERS AND SETTERS */

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Experiment getExperiment() {
        return experiment;
    }

    public void setExperiment(Experiment experiment) {
        this.experiment = experiment;
    }

    public Animal getAnimal() {
        return animal;
    }

    public void setAnimal(Animal animal) {
        this.animal = animal;
    }

    public List<Meal> getMeals() {
        return meals;
    }

    public void setMeals(List<Meal> meals) {
        this.meals = meals;
    }
}
