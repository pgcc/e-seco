package br.ufjf.pgcc.eseco.domain.service.resource;

import br.ufjf.pgcc.eseco.domain.dao.resource.WorkflowServiceCommentDAO;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowServiceComment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class WorkflowServiceCommentService {

    private WorkflowServiceCommentDAO workflowServiceCommentDAO;

    @Autowired
    public WorkflowServiceCommentService(WorkflowServiceCommentDAO workflowServiceCommentDAO) {
        this.workflowServiceCommentDAO = workflowServiceCommentDAO;
    }

    @Transactional
    public WorkflowServiceComment add(WorkflowServiceComment workflowServiceComment) throws Exception{
        return workflowServiceCommentDAO.add(workflowServiceComment);
    }

    public WorkflowServiceComment find(int workflowServiceCommentId) {
        return workflowServiceCommentDAO.find(workflowServiceCommentId);
    }

    public List<WorkflowServiceComment> findAll() {
        return workflowServiceCommentDAO.findAll();
    }
}