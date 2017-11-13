package br.ufjf.pgcc.eseco.domain.service.component;

import br.ufjf.pgcc.eseco.domain.dao.resource.WorkflowServiceDAO;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class WorkflowServiceService {

    private WorkflowServiceDAO workflowServiceDAO;

    @Autowired
    public WorkflowServiceService(WorkflowServiceDAO workflowServiceDAO) {
        this.workflowServiceDAO = workflowServiceDAO;
    }

    @Transactional
    public WorkflowService add(WorkflowService workflowService) throws Exception{
        return workflowServiceDAO.add(workflowService);
    }

    public List<WorkflowService> findAll() {
        return workflowServiceDAO.findAll();
    }

    public WorkflowService findByInternalClass(String internalClass) {
        if (internalClass != null) {
            Map<String, String> map = new HashMap<>();
            map.put("internalClass", internalClass);

            return workflowServiceDAO.findOneBy(map);
        } else {
            return null;
        }
    }

    public void inviteResearcherForRating(WorkflowService workflowService, Researcher researcher){

    }
}