package br.ufjf.pgcc.eseco.domain.service.context;

import br.ufjf.pgcc.eseco.domain.model.context.WorkflowServiceContextModel;
import br.ufjf.pgcc.eseco.domain.model.resource.Component;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WorkflowServiceContextModelService {

    @Autowired
    public WorkflowServiceContextModelService() {

    }


    public WorkflowServiceContextModel createModelInfo(Component component) throws Exception {
        // Get the workflow service of this component
        WorkflowService workflowService = component.getWorkflowService();

        if(null == workflowService){
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
        if(null != workflowService.getInternalClass()){
            ccm.setWsInternalClass(workflowService.getInternalClass());

            Class internalClass = Class.forName(ccm.getWsInternalClass());

            ccm.setWsClassParameterCount(internalClass.getDeclaredFields().length);
            ccm.setWsClassMethodCount(internalClass.getDeclaredMethods().length);
        }

        return ccm;
    }

}