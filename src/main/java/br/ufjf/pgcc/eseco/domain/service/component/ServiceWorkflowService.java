package br.ufjf.pgcc.eseco.domain.service.component;

import br.ufjf.pgcc.eseco.domain.dao.resource.ServiceWorkflowDAO;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ServiceWorkflowService {

    private ServiceWorkflowDAO serviceWorkflowDAO;

    @Autowired
    public ServiceWorkflowService(ServiceWorkflowDAO serviceWorkflowDAO) {
        this.serviceWorkflowDAO = serviceWorkflowDAO;
    }

    @Transactional
    public WorkflowService add(WorkflowService workflowService) throws Exception{
        return serviceWorkflowDAO.add(workflowService);
    }

    public List<WorkflowService> findAll() {
        return serviceWorkflowDAO.findAll();
    }
}