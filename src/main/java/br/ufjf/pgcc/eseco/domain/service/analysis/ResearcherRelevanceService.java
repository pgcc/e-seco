package br.ufjf.pgcc.eseco.domain.service.analysis;

import br.ufjf.pgcc.eseco.domain.model.analysis.ReseacherRelevance;
import br.ufjf.pgcc.eseco.domain.model.context.ResearcherContextModel;
import br.ufjf.pgcc.eseco.domain.model.context.WorkflowServiceContextModel;
import br.ufjf.pgcc.eseco.domain.model.core.Discipline;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import br.ufjf.pgcc.eseco.domain.model.core.ResearcherKeyword;
import br.ufjf.pgcc.eseco.domain.model.experiment.Experiment;
import br.ufjf.pgcc.eseco.domain.model.resource.Component;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowService;
import br.ufjf.pgcc.eseco.domain.service.context.WorkflowServiceContextModelService;
import br.ufjf.pgcc.eseco.domain.service.core.ResearcherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ResearcherRelevanceService {

    private ResearcherService researcherService;
    private WorkflowServiceContextModelService workflowServiceContextModelService;

    @Autowired
    public ResearcherRelevanceService(ResearcherService researcherService,
                                      WorkflowServiceContextModelService workflowServiceContextModelService) {
        this.researcherService = researcherService;
        this.workflowServiceContextModelService = workflowServiceContextModelService;
    }

    private ArrayList<String> extractKeywordsFromWorkflowServiceContext(ArrayList<String> keywords,
                                                                      WorkflowServiceContextModel wscm) {

        keywords.addAll(extractKeywordsFromExperiments(wscm.getExperimentsUsing()));

        if(wscm.getUsedEsecoWorkflowServicesList() == null || wscm.getUsedEsecoWorkflowServicesList().isEmpty()){
            return keywords;
        }

        for(WorkflowServiceContextModel innerWscm : wscm.getUsedEsecoWorkflowServicesList()){
            extractKeywordsFromWorkflowServiceContext(keywords, innerWscm);
        }

        return keywords;
    }

    private ArrayList<String> extractKeywordsFromExperiments(List<Experiment> experimentsList){
        ArrayList<String> keywords = new ArrayList<>();
        for (Experiment experiment : experimentsList) {
            for (String keyword : experiment.getKeywords().split(",")) {
                String k = keyword.trim().toLowerCase();
                if (!keywords.contains(k)) {
                    keywords.add(k);
                }
            }
            for (Discipline discipline : experiment.getDisciplines()) {
                String k = discipline.getName().toLowerCase();
                if (!keywords.contains(k)) {
                    keywords.add(k);
                }
            }
        }

        return keywords;
    }

    public List<ReseacherRelevance> analyseReseachersForWorkflowService(Component component) throws Exception {

        // Get the workflow service of this resource
        WorkflowService workflowService = component.getWorkflowService();

        if (null == workflowService) {
            return null;
        }

        // Create context info for this component
        WorkflowServiceContextModel componentContextInfo = workflowServiceContextModelService.createModelInfo(component);

        if (null == componentContextInfo) {
            return null;
        }

        // Get list of workflow service keywords By its own Experiments
        ArrayList<String> workflowServiceKeywords = new ArrayList<>();
        extractKeywordsFromWorkflowServiceContext(workflowServiceKeywords, componentContextInfo);

        System.out.println("List of Keywords");
        for(String kw : workflowServiceKeywords){
            System.out.println(kw);
        }

        //workflowServiceKeywords.addAll(extractKeywordsFromExperiments(componentContextInfo.getExperimentsUsing()));

        /*
        // By used Workflow services (context composition)
        for(WorkflowServiceContextModel wscm: componentContextInfo.getUsedEsecoWorkflowServicesList()){
            for (Experiment experiment : wscm.getExperimentsUsing()) {
                for (String keyword : experiment.getKeywords().split(",")) {
                    String k = keyword.trim().toLowerCase();
                    if (!workflowServiceKeywords.contains(k)) {
                        workflowServiceKeywords.add(k);
                    }
                }
                for (Discipline discipline : experiment.getDisciplines()) {
                    String k = discipline.getName().toLowerCase();
                    if (!workflowServiceKeywords.contains(k)) {
                        workflowServiceKeywords.add(k);
                    }
                }
            }
        }
        */


        // Get all researchers of the network
        List<Researcher> researcherList = researcherService.findAll();

        List<ReseacherRelevance> reseacherRelevanceList = new ArrayList<>();
        for (Researcher r : researcherList) {

            // Get researcher keywords
            ArrayList<String> researcherKeywords = new ArrayList<>();
            for (ResearcherKeyword rk : r.getResearchKeywords()) {
                String k = rk.getName().toLowerCase();
                if (!researcherKeywords.contains(k)) {
                    researcherKeywords.add(k);
                }
            }
            for (Discipline discipline : r.getDisciplines()) {
                String k = discipline.getName().toLowerCase();
                if (!researcherKeywords.contains(k)) {
                    researcherKeywords.add(k);
                }
            }

            ReseacherRelevance r1 = new ReseacherRelevance();
            r1.setId(r.getId());
            r1.setName(r.getDisplayName());
            r1.setRelevance(calculateRelevance(workflowServiceKeywords, researcherKeywords));

            reseacherRelevanceList.add(r1);
        }

        return reseacherRelevanceList;
    }

    /**
     *
     * @param keywords1 list of main keywords
     * @param keywords2 list of target keywords
     * @return relevance
     */
    private double calculateRelevance(ArrayList<String> keywords1, ArrayList<String> keywords2) {
        int totalSimilarKeywords = 0;
        for (String mainkeyword : keywords1) {
            for (String targetkeyword : keywords2) {
                if (mainkeyword.equals(targetkeyword)) {
                    totalSimilarKeywords++;
                }
            }
        }

        if(totalSimilarKeywords == 0 && keywords1.size() == 0){
            return 0;
        }

        return (double) totalSimilarKeywords / (double) keywords1.size();
    }

}