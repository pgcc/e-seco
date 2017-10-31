package br.ufjf.pgcc.eseco.domain.dao.resource;

import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowService;
import org.springframework.stereotype.Repository;

@Repository
public class ServiceWorkflowDAO extends CommonDAO<WorkflowService, Integer> {

    protected ServiceWorkflowDAO() {
        super(WorkflowService.class);
    }
}