package br.ufjf.pgcc.eseco.domain.service.experiment;

import br.ufjf.pgcc.eseco.domain.dao.experiment.WorkflowDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.Activity;
import br.ufjf.pgcc.eseco.domain.model.experiment.Workflow;
import br.ufjf.pgcc.eseco.domain.model.experiment.WorkflowActivity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class WorkflowService {

    private final WorkflowDAO workflowDAO;

    @Autowired
    public WorkflowService(WorkflowDAO workflowDAO) {
        this.workflowDAO = workflowDAO;
    }

    @Transactional
    public Workflow saveOrUpdate(Workflow workflow) throws Exception {
        if (workflow.getId() == 0 || find(workflow.getId()) == null) {
            return workflowDAO.add(workflow);
        } else {
            return workflowDAO.update(workflow);
        }
    }

    @Transactional
    public void delete(Workflow workflow) throws Exception {
        workflowDAO.delete(workflow);
    }

    public Workflow find(int workflowId) {
        return workflowDAO.find(workflowId);
    }

    public List<Workflow> findAll() {
        return workflowDAO.findAll();
    }

    public List<Workflow> findByActivityId(int activityID) {

        List<Workflow> workflows = findAll();
        ArrayList<Workflow> workflowsFound = new ArrayList<>();

        for(Workflow workflow: workflows){
            for(WorkflowActivity wa: workflow.getActivities()){
                if(wa.getActivity().getId() == activityID){
                    if(!workflowsFound.contains(workflow)){
                        workflowsFound.add(workflow);
                    }
                }
            }
        }

        return workflowsFound;
    }
}
