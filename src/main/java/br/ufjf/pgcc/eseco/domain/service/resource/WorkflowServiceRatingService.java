package br.ufjf.pgcc.eseco.domain.service.resource;

import br.ufjf.pgcc.eseco.domain.dao.resource.WorkflowServiceRatingDAO;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowServiceRating;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class WorkflowServiceRatingService {

    private WorkflowServiceRatingDAO workflowServiceRatingDAO;

    @Autowired
    public WorkflowServiceRatingService(WorkflowServiceRatingDAO workflowServiceRatingDAO) {
        this.workflowServiceRatingDAO = workflowServiceRatingDAO;
    }

    @Transactional
    public WorkflowServiceRating add(WorkflowServiceRating workflowServiceRating) throws Exception{
        return workflowServiceRatingDAO.add(workflowServiceRating);
    }

    public List<WorkflowServiceRating> findAll() {
        return workflowServiceRatingDAO.findAll();
    }
}