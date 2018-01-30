package br.ufjf.pgcc.eseco.scientificDomain.model.agriculture;


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
    private BovineExperiment experiment;

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

    @Column(name = "diaryWeightGain")
    private double diaryWeightGain;

    @Column(name = "meanMetabolicWeight")
    private double meanMetabolicWeight;


    /* GETTERS AND SETTERS */

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public BovineExperiment getExperiment() {
        return experiment;
    }

    public void setExperiment(BovineExperiment experiment) {
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

    public double getDiaryWeightGain() {
        return diaryWeightGain;
    }

    public void setDiaryWeightGain(double diaryWeightGain) {
        this.diaryWeightGain = diaryWeightGain;
    }

    public double getMeanMetabolicWeight() {
        return meanMetabolicWeight;
    }

    public void setMeanMetabolicWeight(double meanMetabolicWeight) {
        this.meanMetabolicWeight = meanMetabolicWeight;
    }
}