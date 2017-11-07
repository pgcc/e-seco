package br.ufjf.pgcc.eseco.domain.model.context;

import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import br.ufjf.pgcc.eseco.domain.model.experiment.Experiment;

import java.util.Date;
import java.util.List;

public class ResearcherContextModel {

    // Basic Info
    private int id;
    private String name;

    // Platform Usage
    private List<Experiment> experimentsUsing;
    private int experimentsUsingCount;
    private List<Researcher> researchersTouched;
    private int researchersTouchedCount;
    private Date memberSince;


    /* CONSTRUCTORS */

    public ResearcherContextModel() {

    }


    /* GETTERS/SETTERS */

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

    public List<Experiment> getExperimentsUsing() {
        return experimentsUsing;
    }

    public void setExperimentsUsing(List<Experiment> experimentsUsing) {
        this.experimentsUsing = experimentsUsing;
    }

    public int getExperimentsUsingCount() {
        return experimentsUsingCount;
    }

    public void setExperimentsUsingCount(int experimentsUsingCount) {
        this.experimentsUsingCount = experimentsUsingCount;
    }

    public List<Researcher> getResearchersTouched() {
        return researchersTouched;
    }

    public void setResearchersTouched(List<Researcher> researchersTouched) {
        this.researchersTouched = researchersTouched;
    }

    public int getResearchersTouchedCount() {
        return researchersTouchedCount;
    }

    public void setResearchersTouchedCount(int researchersTouchedCount) {
        this.researchersTouchedCount = researchersTouchedCount;
    }

    public Date getMemberSince() {
        return memberSince;
    }

    public void setMemberSince(Date memberSince) {
        this.memberSince = memberSince;
    }
}
