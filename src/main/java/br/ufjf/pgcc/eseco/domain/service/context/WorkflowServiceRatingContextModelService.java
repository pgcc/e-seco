package br.ufjf.pgcc.eseco.domain.service.context;

import br.ufjf.pgcc.eseco.domain.model.context.WorkflowServiceRatingContextModel;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowServiceRating;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WorkflowServiceRatingContextModelService {

    @Autowired
    public WorkflowServiceRatingContextModelService() {

    }


    public WorkflowServiceRatingContextModel createModelInfo(WorkflowServiceRating rating) throws Exception {

        WorkflowServiceRatingContextModel wsrcm = new WorkflowServiceRatingContextModel();

        wsrcm.setId(rating.getId());
        wsrcm.setWorkflowServiceId(rating.getWorkflowService().getId());
        wsrcm.setWorkflowServiceName(rating.getWorkflowService().getComponent().getName());
        wsrcm.setAuthorName(rating.getRater().getDisplayName());
        wsrcm.setDateCreated(rating.getDate());
        wsrcm.setValueDocumentation(rating.getValueDocumentation());
        wsrcm.setValueEaseOfUse(rating.getValueEaseOfUse());
        wsrcm.setValueReliability(rating.getValueReliability());
        wsrcm.setValuePerformance(rating.getValuePerformance());
        wsrcm.setValueDisponibility(rating.getValueDisponibility());
        wsrcm.setIsApproved(rating.isApproved() ? "Yes" : "No");

        return wsrcm;
    }

}