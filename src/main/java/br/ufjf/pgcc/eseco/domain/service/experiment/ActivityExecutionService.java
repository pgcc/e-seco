package br.ufjf.pgcc.eseco.domain.service.experiment;

import br.ufjf.pgcc.eseco.domain.dao.experiment.ActivityExecutionDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.ActivityExecution;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class ActivityExecutionService {

    private final ActivityExecutionDAO activityExecutionDAO;

    @Autowired
    public ActivityExecutionService(ActivityExecutionDAO activityExecutionDAO) {
        this.activityExecutionDAO = activityExecutionDAO;
    }

    @Transactional
    public ActivityExecution saveOrUpdate(ActivityExecution activityExecution) throws Exception {
        if (activityExecution.getId() == 0 || find(activityExecution.getId()) == null) {
            return activityExecutionDAO.add(activityExecution);
        } else {
            return activityExecutionDAO.update(activityExecution);
        }
    }

    @Transactional
    public void delete(ActivityExecution activityExecution) throws Exception {
        activityExecutionDAO.delete(activityExecution);
    }

    public ActivityExecution find(int activityExecutionId) {
        return activityExecutionDAO.find(activityExecutionId);
    }

    public List<ActivityExecution> findAll() {
        return activityExecutionDAO.findAll();
    }

}
