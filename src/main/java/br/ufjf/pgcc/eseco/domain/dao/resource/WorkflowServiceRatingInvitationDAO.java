package br.ufjf.pgcc.eseco.domain.dao.resource;

import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowServiceRatingInvitation;
import org.springframework.stereotype.Repository;

@Repository
public class WorkflowServiceRatingInvitationDAO extends CommonDAO<WorkflowServiceRatingInvitation, Integer> {

    protected WorkflowServiceRatingInvitationDAO() {
        super(WorkflowServiceRatingInvitation.class);
    }
}