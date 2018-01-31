package br.ufjf.pgcc.eseco.scientificDomain.model.agriculture;


import javax.persistence.*;

@Entity
@Table(name = "sm_agriculture_experiment_animals_meals")
public class ExperimentAnimalMeal {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private ExperimentAnimal experimentAnimal;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private Meal meal;

    @Column(name = "quantity")
    private double quantity;


    /* GETTERS AND SETTERS */

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public ExperimentAnimal getExperimentAnimal() {
        return experimentAnimal;
    }

    public void setExperimentAnimal(ExperimentAnimal experimentAnimal) {
        this.experimentAnimal = experimentAnimal;
    }

    public Meal getMeal() {
        return meal;
    }

    public void setMeal(Meal meal) {
        this.meal = meal;
    }

    public double getQuantity() {
        return quantity;
    }

    public void setQuantity(double quantity) {
        this.quantity = quantity;
    }
}
