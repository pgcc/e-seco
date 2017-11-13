package br.ufjf.pgcc.eseco.domain.service.resource;

import br.ufjf.pgcc.eseco.domain.dao.resource.WorkflowServiceRatingInvitationDAO;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowServiceRatingInvitation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class WorkflowServiceRatingInvitationService {

    private WorkflowServiceRatingInvitationDAO workflowServiceRatingInvitationDAO;

    @Autowired
    public WorkflowServiceRatingInvitationService(WorkflowServiceRatingInvitationDAO workflowServiceRatingInvitationDAO) {
        this.workflowServiceRatingInvitationDAO = workflowServiceRatingInvitationDAO;
    }

    @Transactional
    public WorkflowServiceRatingInvitation add(WorkflowServiceRatingInvitation workflowServiceRatingInvitation) throws Exception {
        return workflowServiceRatingInvitationDAO.add(workflowServiceRatingInvitation);
    }

    @Transactional
    public WorkflowServiceRatingInvitation update(WorkflowServiceRatingInvitation workflowServiceRatingInvitation) throws Exception {
        return workflowServiceRatingInvitationDAO.update(workflowServiceRatingInvitation);
    }

    public WorkflowServiceRatingInvitation find(int workflowServiceRatingInvitationId) {
        return workflowServiceRatingInvitationDAO.find(workflowServiceRatingInvitationId);
    }

    public List<WorkflowServiceRatingInvitation> findAll() {
        return workflowServiceRatingInvitationDAO.findAll();
    }

 }