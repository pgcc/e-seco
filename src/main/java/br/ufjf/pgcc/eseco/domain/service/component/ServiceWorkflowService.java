package br.ufjf.pgcc.eseco.domain.service.component;

import br.ufjf.pgcc.eseco.domain.dao.resource.ServiceWorkflowDAO;
import br.ufjf.pgcc.eseco.domain.model.resource.ServiceWorkflow;
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
    public ServiceWorkflow add(ServiceWorkflow serviceWorkflow) throws Exception{
        return serviceWorkflowDAO.add(serviceWorkflow);
    }

    @Transactional(readOnly = true)
    public List<ServiceWorkflow> findAll() {
        return serviceWorkflowDAO.findAll();
    }
}