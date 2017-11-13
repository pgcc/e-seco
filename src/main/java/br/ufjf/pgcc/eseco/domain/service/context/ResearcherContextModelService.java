package br.ufjf.pgcc.eseco.domain.service.context;

import br.ufjf.pgcc.eseco.domain.model.context.ResearcherContextModel;
import br.ufjf.pgcc.eseco.domain.model.context.WorkflowServiceRatingContextModel;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowServiceRating;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ResearcherContextModelService {

    @Autowired
    public ResearcherContextModelService() {

    }


    public ResearcherContextModel createModelInfo(Researcher researcher) throws Exception {

        ResearcherContextModel rcm = new ResearcherContextModel();

        rcm.setId(researcher.getId());

        return rcm;
    }

}