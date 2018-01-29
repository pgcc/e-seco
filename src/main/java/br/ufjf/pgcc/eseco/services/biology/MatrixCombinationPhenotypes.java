package br.ufjf.pgcc.eseco.services.biology;

import br.ufjf.pgcc.eseco.domain.annotation.ComposedOf;
import br.ufjf.pgcc.eseco.domain.annotation.EsecoWorkflowService;
import br.ufjf.pgcc.eseco.scientificDomain.model.biology.PhenotypePiece;
import br.ufjf.pgcc.eseco.scientificDomain.model.biology.PhenotypeRelation;

import java.util.ArrayList;
import java.util.List;

@EsecoWorkflowService
@ComposedOf(servicesClasses = {
        PhenotypePiece.class,
        PhenotypeRelation.class
})
public class MatrixCombinationPhenotypes {

    /*
    @POST
    @Produces(MediaType.APPLICATION_JSON)
    */
    public List<PhenotypePiece> generateMatrix(List<PhenotypeRelation> f) {

        String[] s1 = f.get(0).getPhenotype().split(";");
        String[] s2 = f.get(1).getPhenotype().split(";");
        ArrayList<String> phenoPieces1 = new ArrayList<String>();
        ArrayList<String> phenoPieces2 = new ArrayList<String>();
        ArrayList<PhenotypePiece> phenoPiecesCombine = new ArrayList<PhenotypePiece>();

        for(int i=0; i<s1.length;i++){
            String[] temp = s1[i].split("-");
            for(int j=0; j<temp.length;j++){

                phenoPieces1.add(temp[j]);

            }
        }

        for(int i=0; i<s2.length;i++){
            String[] temp = s2[i].split("-");
            for(int j=0; j<temp.length;j++){
                phenoPieces2.add(temp[j]);
            }
        }

        for(String ph1: phenoPieces1){
            PhenotypePiece pp1= new PhenotypePiece();
            pp1.setPhenotypePiece(ph1);
            for(String ph2: phenoPieces2){
                PhenotypePiece pp2= new PhenotypePiece();
                pp2.setPhenotypePiece(ph2);
                phenoPiecesCombine.add(pp1);
                phenoPiecesCombine.add(pp2);
            }

        }
        return phenoPiecesCombine;
    }

}
