package br.ufjf.pgcc.eseco.services.biology;

import br.ufjf.pgcc.eseco.domain.annotation.ComposedOf;
import br.ufjf.pgcc.eseco.domain.annotation.EsecoWorkflowService;

@EsecoWorkflowService
@ComposedOf(servicesClasses = {
        BiologicalSpecimenScientificNameRetriever.class,
        FetchBarCode.class,
        SpecimenInformationSearch.class
})
public class SearchSpecimenInformationBySpecimenName {

    private String getSpecimenScientificName(String commonName){
        BiologicalSpecimenScientificNameRetriever bssnr = new BiologicalSpecimenScientificNameRetriever();
        return bssnr.getSpecimenScientificNameBySpecimenName(commonName);
    }

    private String getSpecimenBarCode(String scientificName){
        FetchBarCode fbc = new FetchBarCode();
        return fbc.getBarCodeBySpecimenScientificName(scientificName);
    }

    private String getSpecimenInfoByBarCode(String barCode){
        SpecimenInformationSearch sis = new SpecimenInformationSearch();
        return sis.getSpecimenInfoByBarCode(barCode);
    }

    public String getSpecimenInfoByName(String commonName){
        String scientificName = getSpecimenScientificName(commonName);
        String barCode = getSpecimenBarCode(scientificName);
        String specimenInfo = getSpecimenInfoByBarCode(barCode);

        return specimenInfo;
    }
}
