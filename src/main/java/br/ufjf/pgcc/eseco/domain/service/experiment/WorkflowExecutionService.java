package br.ufjf.pgcc.eseco.domain.service.experiment;

import br.ufjf.pgcc.eseco.domain.dao.experiment.WorkflowExecutionDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.WorkflowExecution;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class WorkflowExecutionService {

    private final WorkflowExecutionDAO workflowExecutionDAO;

    @Autowired
    public WorkflowExecutionService(WorkflowExecutionDAO workflowExecutionDAO) {
        this.workflowExecutionDAO = workflowExecutionDAO;
    }

    @Transactional
    public WorkflowExecution saveOrUpdate(WorkflowExecution workflowExecution) throws Exception {
        if (workflowExecution.getId() == 0 || find(workflowExecution.getId()) == null) {
            return workflowExecutionDAO.add(workflowExecution);
        } else {
            return workflowExecutionDAO.update(workflowExecution);
        }
    }

    @Transactional
    public void delete(WorkflowExecution workflowExecution) throws Exception {
        workflowExecutionDAO.delete(workflowExecution);
    }

    public WorkflowExecution find(int workflowExecutionId) {
        return workflowExecutionDAO.find(workflowExecutionId);
    }

    public List<WorkflowExecution> findAll() {
        return workflowExecutionDAO.findAll();
    }

}
