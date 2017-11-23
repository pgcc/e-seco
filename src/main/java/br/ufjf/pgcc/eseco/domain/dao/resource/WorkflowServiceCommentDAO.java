package br.ufjf.pgcc.eseco.domain.dao.resource;

import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowServiceComment;
import org.springframework.stereotype.Repository;

@Repository
public class WorkflowServiceCommentDAO extends CommonDAO<WorkflowServiceComment, Integer> {

    protected WorkflowServiceCommentDAO() {
        super(WorkflowServiceComment.class);
    }
}