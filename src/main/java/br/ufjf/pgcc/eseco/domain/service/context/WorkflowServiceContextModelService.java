package br.ufjf.pgcc.eseco.domain.service.context;

import br.ufjf.pgcc.eseco.domain.annotation.ComposedOf;
import br.ufjf.pgcc.eseco.domain.annotation.EsecoWorkflowService;
import br.ufjf.pgcc.eseco.domain.model.context.WorkflowServiceContextModel;
import br.ufjf.pgcc.eseco.domain.model.core.Discipline;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import br.ufjf.pgcc.eseco.domain.model.experiment.Activity;
import br.ufjf.pgcc.eseco.domain.model.experiment.Experiment;
import br.ufjf.pgcc.eseco.domain.model.experiment.Workflow;
import br.ufjf.pgcc.eseco.domain.model.resource.Component;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowService;
import br.ufjf.pgcc.eseco.domain.service.component.WorkflowServiceService;
import br.ufjf.pgcc.eseco.domain.service.experiment.ActivityService;
import br.ufjf.pgcc.eseco.domain.service.experiment.ExperimentService;
import br.ufjf.pgcc.eseco.domain.service.metrics.ClassInternalMetricsModelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class WorkflowServiceContextModelService {

    private WorkflowServiceService workflowServiceService;
    private ClassInternalMetricsModelService classInternalMetricsModelService;
    private ActivityService activityService;
    private br.ufjf.pgcc.eseco.domain.service.experiment.WorkflowService experimentWorkflowService;
    private ExperimentService experimentService;

    @Autowired
    public WorkflowServiceContextModelService(WorkflowServiceService workflowServiceService,
                                              ClassInternalMetricsModelService classInternalMetricsModelService,
                                              ActivityService activityService,
                                              br.ufjf.pgcc.eseco.domain.service.experiment.WorkflowService experimentWorkflowService,
                                              ExperimentService experimentService) {
        this.workflowServiceService = workflowServiceService;
        this.classInternalMetricsModelService = classInternalMetricsModelService;
        this.activityService = activityService;
        this.experimentWorkflowService = experimentWorkflowService;
        this.experimentService = experimentService;
    }


    public WorkflowServiceContextModel createModelInfo(Component component) throws Exception {
        // Get the workflow service of this component
        WorkflowService workflowService = component.getWorkflowService();

        if (null == workflowService) {
            return null;
        }

        WorkflowServiceContextModel ccm = new WorkflowServiceContextModel();

        // Get Basic info from Component
        ccm.setId(component.getId());
        ccm.setName(component.getName());
        ccm.setType(component.getType().getName());
        ccm.setAuthor(component.getAuthor().getAgent().getName());
        ccm.setDateCreated(component.getDateCreated());
        ccm.setDateUpdated(component.getDateUpdated());

        // Get Basic info from WorkflowService
        ccm.setWsType(workflowService.getType());
        ccm.setWsNature(workflowService.getNature());
        ccm.setWsUrl(workflowService.getUrl());

        // Get Internal Class information
        if (null != workflowService.getInternalClass()) {

            ccm.setWsInternalClass(workflowService.getInternalClass());

            // Get Internal Metrics for the Internal Class
            Class internalClass = Class.forName(workflowService.getInternalClass());
            ccm.setWsInternalClassInternalMetrics(classInternalMetricsModelService.createModelInfo(internalClass));

            // Read possible services that composes this one
            ComposedOf composedOfAnnotation = (ComposedOf) internalClass.getAnnotation(ComposedOf.class);
            if (null != composedOfAnnotation) {
                ArrayList<String> usedEsecoCoreServicesList = new ArrayList<>();
                ArrayList<WorkflowServiceContextModel> usedEsecoWorkflowServicesList = new ArrayList<>();

                Class<?>[] servicesClasses = composedOfAnnotation.servicesClasses();
                for (Class<?> serviceClass : servicesClasses) {

                    // Verify if it is a ESECO Workflow Service
                    EsecoWorkflowService esecoWorkflowServiceAnnotation = serviceClass.getAnnotation(EsecoWorkflowService.class);
                    if(null != esecoWorkflowServiceAnnotation){
                        WorkflowService ws = workflowServiceService.findByInternalClass(serviceClass.getName());
                        if (null != ws) {
                            WorkflowServiceContextModel wscm = createModelInfo(ws.getComponent());
                            usedEsecoWorkflowServicesList.add(wscm);
                        }
                    }else{
                        usedEsecoCoreServicesList.add(serviceClass.getName());
                    }
                }

                ccm.setUsedEsecoCoreServicesList(usedEsecoCoreServicesList);
                ccm.setUsedEsecoWorkflowServicesList(usedEsecoWorkflowServicesList);
            }
        }

        // Get Usage Data
        ccm.setActivitiesUsing(activityService.findByWorkflowServiceId(workflowService.getId()));
        ccm.setActivitiesUsingCount(ccm.getActivitiesUsing().size());

        ArrayList<Workflow> workflowsFound = new ArrayList<>();
        ArrayList<Experiment> experimentsFound = new ArrayList<>();
        ArrayList<Researcher> researchersFound = new ArrayList<>();

        // Workflows
        for(Activity activity: ccm.getActivitiesUsing()){
            List<Workflow> workflowsUsingActivity = experimentWorkflowService.findByActivityId(activity.getId());
            for(Workflow wf: workflowsUsingActivity){

                boolean insertWsIntoFoundList = true;

                for(Workflow wsInWorkflowsFoundList: workflowsFound){
                    if(wsInWorkflowsFoundList.getId() == wf.getId()){
                        insertWsIntoFoundList = false;
                    }
                }

                if(insertWsIntoFoundList){
                    workflowsFound.add(wf);
                }
            }
        }

        // Experiments
        for(Workflow wf: workflowsFound){
            List<Experiment> experimentsUsingActivity = experimentService.findByWorkflowId(wf.getId());
            for(Experiment exp: experimentsUsingActivity){

                boolean insertIntoFoundList = true;

                for(Experiment expInFoundList: experimentsFound){
                    if(expInFoundList.getId() == exp.getId()){
                        insertIntoFoundList = false;
                    }
                }

                if(insertIntoFoundList){
                    experimentsFound.add(exp);
                }
            }
        }

        // Researchers
        for(Experiment experiment: experimentsFound){
            // Author of experiment
            Researcher experimentAuthor = experiment.getAuthor();
            if(!researchersFound.contains(experimentAuthor)){
                researchersFound.add(experimentAuthor);
            }

            // Others researchers
            for(Researcher experimentResearcher: experiment.getResearchers()) {

                boolean insertIntoFoundList = true;

                for(Researcher researcherInFoundList: researchersFound){
                    if(researcherInFoundList.getId() == experimentResearcher.getId()){
                        insertIntoFoundList = false;
                    }
                }

                if(insertIntoFoundList){
                    researchersFound.add(experimentResearcher);
                }
            }
        }

        ccm.setWorkflowsUsing(workflowsFound);
        ccm.setWorkflowsUsingCount(workflowsFound.size());

        ccm.setExperimentsUsing(experimentsFound);
        ccm.setExperimentsUsingCount(experimentsFound.size());

        ccm.setResearchersUsing(researchersFound);
        ccm.setResearchersUsingCount(researchersFound.size());

        // Most Used Area
        String mostUsedAreaName = "";
        int mostUsedAreaQuantity = 0;
        HashMap<String, Integer> experimentsAreas = new HashMap<>();
        for(Experiment experiment: experimentsFound){
            for(Discipline discipline: experiment.getDisciplines()){

                if(!experimentsAreas.containsKey(discipline.getName())){
                    experimentsAreas.put(discipline.getName(), 1);
                }else{
                    experimentsAreas.put(discipline.getName(), experimentsAreas.get(discipline.getName()) + 1);
                }
            }
        }

        for (Map.Entry<String, Integer> entry : experimentsAreas.entrySet()) {
            String key = entry.getKey();
            int value = entry.getValue();

            if(value > mostUsedAreaQuantity){
                mostUsedAreaName = key;
                mostUsedAreaQuantity = value;
            }
        }

        ccm.setMostCommonArea(mostUsedAreaName);

        // Ratings


        return ccm;
    }

}