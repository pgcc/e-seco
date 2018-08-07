package br.ufjf.pgcc.eseco.domain.service.experiment;

import br.ufjf.pgcc.eseco.domain.dao.experiment.ActivityDAO;
import br.ufjf.pgcc.eseco.domain.dao.experiment.WorkflowDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.Activity;
import br.ufjf.pgcc.eseco.domain.model.experiment.WorkflowActivity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class ActivityService {

    private final ActivityDAO activityDAO;
    private final WorkflowDAO workflowDAO;

    @Autowired
    public ActivityService(ActivityDAO activityDAO, WorkflowDAO workflowDAO) {
        this.activityDAO = activityDAO;
        this.workflowDAO = workflowDAO;
    }

    @Transactional
    public Activity saveOrUpdate(Activity activity) throws Exception {
        if (activity.getId() == 0 || find(activity.getId()) == null) {
            return activityDAO.add(activity);
        } else {
            return activityDAO.update(activity);
        }
    }

    @Transactional
    public void delete(Activity activity) throws Exception {
        activityDAO.delete(activity);
    }

    public Activity find(int activityId) {
        return activityDAO.find(activityId);
    }

    public List<Activity> findAll() {
        return activityDAO.findAll();
    }

    public List<Activity> findByWorkflowServiceId(int workflowServiceID) {

        List<Activity> activities = findAll();
        ArrayList<Activity> activitiesFound = new ArrayList<>();

        for (Activity activity : activities) {
            for (br.ufjf.pgcc.eseco.domain.model.resource.WorkflowService ws : activity.getWorkflowServices()) {
                if (ws.getId() == workflowServiceID) {
                    if (!activitiesFound.contains(activity)) {
                        activitiesFound.add(activity);
                    }
                }
            }
        }

        return activitiesFound;
    }

    public List<Activity> findByWorkflowIdAndOrder(int workflowID, int orderExec) {

        ArrayList<Activity> activitiesFound = new ArrayList<>();

        for (WorkflowActivity wa : workflowDAO.find(workflowID).getActivities()) {
            if (wa.getOrderExec() == orderExec) {
                if (!activitiesFound.contains(wa.getActivity())) {
                    activitiesFound.add(wa.getActivity());
                }
            }
        }
        return activitiesFound;
    }

}
