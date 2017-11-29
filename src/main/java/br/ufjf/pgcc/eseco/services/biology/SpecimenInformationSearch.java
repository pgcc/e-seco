package br.ufjf.pgcc.eseco.services.biology;

import br.ufjf.pgcc.eseco.domain.annotation.ComposedOf;
import br.ufjf.pgcc.eseco.domain.annotation.EsecoWorkflowService;
import br.ufjf.pgcc.eseco.scientificModels.biology.Specimen;

@EsecoWorkflowService
@ComposedOf(servicesClasses = {
        Specimen.class
})
public class SpecimenInformationSearch {

    public String getSpecimenInfoByBarCode(String barCode){
        // Processing here



        return "";
    }
}
