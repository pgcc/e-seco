package br.ufjf.pgcc.eseco.services.biology;

import br.ufjf.pgcc.eseco.domain.annotation.EsecoWorkflowService;

@EsecoWorkflowService
public class GeneExtractor {

    private String gene;

    public String extract(){
        return "return extracted gene";
    }

    public String getGene() {
        return gene;
    }

    public void setGene(String gene) {
        this.gene = gene;
    }
}
