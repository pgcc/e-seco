package br.ufjf.pgcc.eseco.services.biology;

import br.ufjf.pgcc.eseco.domain.annotation.ComposedOf;
import br.ufjf.pgcc.eseco.domain.annotation.EsecoWorkflowService;
import br.ufjf.pgcc.eseco.scientificModels.biology.Specimen;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@EsecoWorkflowService
@ComposedOf(servicesClasses = {
        BiologicalSpecimenScientificNameRetriever.class,
        FetchBarCode.class,
        SpecimenInformationSearch.class,
        Specimen.class
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

    public String getSpecimenInfoByName(String commonName){
        String scientificName = getSpecimenScientificName(commonName);
        String barCode = getSpecimenBarCode(scientificName);

        Specimen specimen = new Specimen();
        specimen.setCommonName(commonName);
        specimen.setScientificName(scientificName);
        specimen.setBarCode(barCode);

        Gson gson = new GsonBuilder().create();
        String specimenJson = gson.toJson(specimen);

        return specimenJson;
    }

    public Specimen getSpecimenByName(String commonName){
        String scientificName = getSpecimenScientificName(commonName);
        String barCode = getSpecimenBarCode(scientificName);

        Specimen specimen = new Specimen();
        specimen.setCommonName(commonName);
        specimen.setScientificName(scientificName);
        specimen.setBarCode(barCode);

        return specimen;
    }
}
