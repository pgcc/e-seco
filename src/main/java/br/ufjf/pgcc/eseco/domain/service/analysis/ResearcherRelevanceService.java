package br.ufjf.pgcc.eseco.domain.service.analysis;

import br.ufjf.pgcc.eseco.domain.model.analysis.ReseacherRelevance;
import br.ufjf.pgcc.eseco.domain.model.context.ResearcherContextModel;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import br.ufjf.pgcc.eseco.domain.model.resource.Component;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowService;
import br.ufjf.pgcc.eseco.domain.service.core.ResearcherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ResearcherRelevanceService {

    private ResearcherService researcherService;

    @Autowired
    public ResearcherRelevanceService(ResearcherService researcherService) {
        this.researcherService = researcherService;
    }


    public List<ReseacherRelevance> analyseReseachersForWorkflowService(Component component) throws Exception {

        // Get the workflow service of this resource
        WorkflowService workflowService = component.getWorkflowService();

        if (null == workflowService) {
            return null;
        }

        // Get all researchers of the network
        List<Researcher> researcherList = researcherService.findAll();


        List<ReseacherRelevance> reseacherRelevanceList = new ArrayList<>();
        for(Researcher r: researcherList){
            ReseacherRelevance r1 = new ReseacherRelevance();
            r1.setId(r.getId());
            r1.setName(r.getDisplayName());
            r1.setRelevance(784.65);

            reseacherRelevanceList.add(r1);
        }




        return reseacherRelevanceList;
    }

}