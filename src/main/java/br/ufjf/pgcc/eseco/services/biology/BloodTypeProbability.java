package br.ufjf.pgcc.eseco.services.biology;

import br.ufjf.pgcc.eseco.domain.annotation.ComposedOf;
import br.ufjf.pgcc.eseco.domain.annotation.EsecoWorkflowService;
import br.ufjf.pgcc.eseco.scientificModels.biology.BloodTypeProbabilitiesTable;
import br.ufjf.pgcc.eseco.scientificModels.biology.PhenotypePiece;

import java.util.List;

@EsecoWorkflowService
@ComposedOf(servicesClasses = {
        BloodTypeProbabilitiesTable.class
})
public class BloodTypeProbability {

    /*
    @POST
    @Produces(MediaType.APPLICATION_JSON)
    */
    public BloodTypeProbabilitiesTable calculate(List<PhenotypePiece> phenotypes) {
        float total = phenotypes.size()/2;
        float A =0, AB = 0, B = 0, O = 0;
        for(int i=0;i<phenotypes.size();i+=2){
            String type = phenotypes.get(i).getPhenotypePiece().concat(phenotypes.get(i+1).getPhenotypePiece());
            if(type.equalsIgnoreCase("IAi")|| type.equalsIgnoreCase("iIA")||type.equalsIgnoreCase("IAIA")){
                A++;
            }
            if(type.equalsIgnoreCase("IBi")|| type.equalsIgnoreCase("iIB")||type.equalsIgnoreCase("IBIB")){
                B++;
            }
            if(type.equalsIgnoreCase("IAIB")|| type.equalsIgnoreCase("IBIA")){
                AB++;
            }
            if(type.equalsIgnoreCase("ii")){
                O++;
            }

        }

        BloodTypeProbabilitiesTable bTable = new BloodTypeProbabilitiesTable();
        bTable.setPercentageA(String.valueOf((A/total)*100));
        bTable.setPercentageB(String.valueOf((B/total)*100));
        bTable.setPercentageAB(String.valueOf((AB/total)*100));
        bTable.setPercentageO(String.valueOf((O/total)*100));

        return bTable;
    }

}
