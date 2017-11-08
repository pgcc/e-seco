/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.domain.model.experiment;

import br.ufjf.pgcc.eseco.domain.model.core.Discipline;
import br.ufjf.pgcc.eseco.domain.model.core.Institution;
import br.ufjf.pgcc.eseco.domain.model.core.ResearchGroup;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import java.util.Date;
import java.util.List;
import javax.persistence.*;
import javax.persistence.Entity;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.springframework.format.annotation.DateTimeFormat;

/**
 *
 * @author Lenita
 */
@Entity
@Table(name = "exp_experiments")
public class Experiment {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "name")
    private String name;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "author_id", nullable = false)
    private Researcher author;

    @Column(name = "date_created", columnDefinition = "DATE")
    @Temporal(value = TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy/MM/dd")
    private Date dateCreated;

    @Column(name = "date_updated", columnDefinition = "DATE")
    @DateTimeFormat(pattern = "yyyy/MM/dd")
    @Temporal(value = TemporalType.DATE)
    private Date dateUpdated;

    @Column(name = "date_ended", columnDefinition = "DATE")
    @Temporal(value = TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy/MM/dd")
    private Date dateEnded;

    @Column(name = "status")
    private ExperimentStatus status;

    @Column(name = "current_phase")
    private ExperimentPhase currentPhase;

    @Column(name = "version")
    private String version;

    @ManyToMany
    @LazyCollection(LazyCollectionOption.FALSE)
    @JoinTable(
            name = "exp_experiment_discipline",
            joinColumns = {
                @JoinColumn(name = "experiment_id", nullable = false)
            },
            inverseJoinColumns = {
                @JoinColumn(name = "discipline_id", nullable = false)
            }
    )
    private List<Discipline> disciplines;

    @Column(name = "key_words")
    private String keywords;

    @ManyToMany
    @LazyCollection(LazyCollectionOption.FALSE)
    @JoinTable(
            name = "exp_experiment_institution",
            joinColumns = {
                @JoinColumn(name = "experiment_id", nullable = false)
            },
            inverseJoinColumns = {
                @JoinColumn(name = "institution_id", nullable = false)
            }
    )
    private List<Institution> institutions;

    @ManyToMany
    @LazyCollection(LazyCollectionOption.FALSE)
    @JoinTable(
            name = "exp_experiment_researcher",
            joinColumns = {
                @JoinColumn(name = "experiment_id", nullable = false)
            },
            inverseJoinColumns = {
                @JoinColumn(name = "researcher_id", nullable = false)
            }
    )
    private List<Researcher> researchers;

    @ManyToMany
    @LazyCollection(LazyCollectionOption.FALSE)
    @JoinTable(
            name = "exp_experiment_research_group",
            joinColumns = {
                @JoinColumn(name = "experiment_id", nullable = false)
            },
            inverseJoinColumns = {
                @JoinColumn(name = "research_group_id", nullable = false)
            }
    )
    private List<ResearchGroup> researchGroups;

    @ManyToMany
    @LazyCollection(LazyCollectionOption.FALSE)
    @JoinTable(
            name = "exp_experiment_workflow",
            joinColumns = {
                @JoinColumn(name = "experiment_id", nullable = false)
            },
            inverseJoinColumns = {
                @JoinColumn(name = "workflow_id", nullable = false)
            }
    )
    private List<Workflow> workflows;

    public Experiment() {
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    public Date getDateEnded() {
        return dateEnded;
    }

    public void setDateEnded(Date dateEnded) {
        this.dateEnded = dateEnded;
    }

    public ExperimentStatus getStatus() {
        return status;
    }

    public void setStatus(ExperimentStatus status) {
        this.status = status;
    }

    public ExperimentPhase getCurrentPhase() {
        return currentPhase;
    }

    public void setCurrentPhase(ExperimentPhase currentPhase) {
        this.currentPhase = currentPhase;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public List<Discipline> getDisciplines() {
        return disciplines;
    }

    public void setDisciplines(List<Discipline> disciplines) {
        this.disciplines = disciplines;
    }

    public String getKeywords() {
        return keywords;
    }

    public void setKeywords(String keywords) {
        this.keywords = keywords;
    }

    public List<Institution> getInstitutions() {
        return institutions;
    }

    public void setInstitutions(List<Institution> institutions) {
        this.institutions = institutions;
    }

    public List<Researcher> getResearchers() {
        return researchers;
    }

    public void setResearchers(List<Researcher> researchers) {
        this.researchers = researchers;
    }

    public List<ResearchGroup> getResearchGroups() {
        return researchGroups;
    }

    public void setResearchGroups(List<ResearchGroup> researchGroups) {
        this.researchGroups = researchGroups;
    }

    public List<Workflow> getWorkflows() {
        return workflows;
    }

    public void setWorkflows(List<Workflow> workflows) {
        this.workflows = workflows;
    }

    public boolean isNew() {
        return (this.id == 0);
    }

    @Override
    public String toString() {
        return String.valueOf(id);
    }
}
