package br.ufjf.pgcc.eseco.domain.dao.resource;

import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import br.ufjf.pgcc.eseco.domain.model.resource.ServiceWorkflow;
import org.springframework.stereotype.Repository;

@Repository
public class ServiceWorkflowDAO extends CommonDAO<ServiceWorkflow, Integer> {

    protected ServiceWorkflowDAO() {
        super(ServiceWorkflow.class);
    }
}