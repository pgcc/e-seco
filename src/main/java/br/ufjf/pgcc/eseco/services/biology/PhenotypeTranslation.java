package br.ufjf.pgcc.eseco.services.biology;

import br.ufjf.pgcc.eseco.domain.annotation.ComposedOf;
import br.ufjf.pgcc.eseco.domain.annotation.EsecoWorkflowService;
import br.ufjf.pgcc.eseco.scientificDomain.model.biology.BloodType;
import br.ufjf.pgcc.eseco.scientificDomain.model.biology.PhenotypeRelation;

import javax.xml.bind.annotation.XmlRootElement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@EsecoWorkflowService
@ComposedOf(servicesClasses = {
        BloodType.class,
        PhenotypeRelation.class
})
@XmlRootElement
public class PhenotypeTranslation {
    static private Map<String, String> fenotiposMap;

    static {
        fenotiposMap = new HashMap<String, String>();
        fenotiposMap.put("A", "IA-i;IA-IA");
        fenotiposMap.put("B", "IB-i;IB-IB");
        fenotiposMap.put("O", "i-i");
        fenotiposMap.put("AB", "IA-IB");
    }

    /*
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/{fenotipos}")
    */
    public List<PhenotypeRelation> translate(/*@PathParam("fenotipos")*/ String fenotipos) {
        BloodType father = new BloodType();
        BloodType mother = new BloodType();

        String[] f = fenotipos.split("&");
        father.setType(f[0]);
        mother.setType(f[1]);

        List<PhenotypeRelation> types = new ArrayList<PhenotypeRelation>();
        PhenotypeRelation f1 = new PhenotypeRelation();
        f1.setType(father.getType());
        f1.setPhenotype(fenotiposMap.get(father.getType()));

        PhenotypeRelation f2 = new PhenotypeRelation();
        f2.setType(mother.getType());
        f2.setPhenotype(fenotiposMap.get(mother.getType()));

        types.add(f1);
        types.add(f2);
        return types;
    }
}