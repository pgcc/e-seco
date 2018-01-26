package br.ufjf.pgcc.eseco.services.biology;

import br.ufjf.pgcc.eseco.domain.annotation.ComposedOf;
import br.ufjf.pgcc.eseco.domain.annotation.EsecoWorkflowService;

import java.io.IOException;

@EsecoWorkflowService
@ComposedOf(servicesClasses = {
        BiologicalSpecimenScientificNameRetriever.class,
        FetchBarCode.class,
        SpecimenInformationSearch.class
})
public class SearchSpecimenInformationBySpecimenName {

    private String getSpecimenScientificName(String commonName) throws IOException {
        BiologicalSpecimenScientificNameRetriever bssnr = new BiologicalSpecimenScientificNameRetriever();
        return bssnr.getSpecimenScientificNameBySpecimenName(commonName);
    }

    private String getSpecimenBarCode(String scientificName) throws IOException {
        FetchBarCode fbc = new FetchBarCode();
        return fbc.getBarCodeBySpecimenScientificName(scientificName);
    }

    private String getSpecimenInfoByBarCode(String barCode) throws IOException {
        SpecimenInformationSearch sis = new SpecimenInformationSearch();
        return sis.getSpecimenInfoByBarCode(barCode);
    }

    public String getSpecimenInfoByName(String commonName) throws IOException {
        String scientificName = getSpecimenScientificName(commonName);
        String barCode = getSpecimenBarCode(scientificName);
        String specimenInfo = getSpecimenInfoByBarCode(barCode);

        return specimenInfo;
    }
}
