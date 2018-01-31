package br.ufjf.pgcc.eseco.services.agriculture;


import br.ufjf.pgcc.eseco.domain.annotation.ComposedOf;
import br.ufjf.pgcc.eseco.domain.annotation.EsecoWorkflowService;
import com.google.gson.Gson;


import java.util.HashMap;
import java.util.Map;

@EsecoWorkflowService
@ComposedOf(servicesClasses = {DryMatterIngestionIndex.class,
        MeanExperimentDiaryWeightGain.class,
        MeanExperimentMeanMetabolicWeight.class})

public class CARIndex {

    public String CAR(int lnCodExperimento) {

        DryMatterIngestionIndex oDryMatterIngestionIndex =
                new DryMatterIngestionIndex();
        MeanExperimentDiaryWeightGain oMeanExperimentDiaryWeightGain =
                new MeanExperimentDiaryWeightGain();
        MeanExperimentMeanMetabolicWeight oMeanExperimentMeanMetabolicWeight =
                new MeanExperimentMeanMetabolicWeight();

        double nIMS = oDryMatterIngestionIndex.getIMS(lnCodExperimento);
        double nGPD = oMeanExperimentDiaryWeightGain.getGPD(lnCodExperimento);
        double nPM_Medio = oMeanExperimentMeanMetabolicWeight.getPmMedio(lnCodExperimento);

        double nRetorno = regression_math(nIMS,nGPD,nPM_Medio);
        Map<String, Double> map = new HashMap<>();
        map.put("INDEX_CAR", nRetorno);

        Gson gson = new Gson();
        return gson.toJson(map);


    }
    public double regression_math(double y, double b0, double b1){
        return 1.667;

    }


}
