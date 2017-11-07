package br.ufjf.pgcc.eseco.domain.dao.resource;

import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowServiceRating;
import org.springframework.stereotype.Repository;

@Repository
public class WorkflowServiceRatingDAO extends CommonDAO<WorkflowServiceRating, Integer> {

    protected WorkflowServiceRatingDAO() {
        super(WorkflowServiceRating.class);
    }
}