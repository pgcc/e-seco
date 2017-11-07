package br.ufjf.pgcc.eseco.domain.service.metrics;

import br.ufjf.pgcc.eseco.domain.annotation.ComposedOf;
import br.ufjf.pgcc.eseco.domain.annotation.EsecoWorkflowService;
import br.ufjf.pgcc.eseco.domain.model.context.WorkflowServiceContextModel;
import br.ufjf.pgcc.eseco.domain.model.metrics.ClassInternalMetricsModel;
import br.ufjf.pgcc.eseco.domain.model.resource.Component;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ClassInternalMetricsModelService {

    @Autowired
    public ClassInternalMetricsModelService() {

    }


    public ClassInternalMetricsModel createModelInfo(Class<?> classToInspect) throws Exception {

        ClassInternalMetricsModel cimm = new ClassInternalMetricsModel();

        // Get Internal Class information
        cimm.setParametersCount(classToInspect.getDeclaredFields().length);
        cimm.setMethodsCount(classToInspect.getDeclaredMethods().length);

        // Read possible services that composes this one
        int totalServicesCount = 0;
        int totalEsecoWorkflowServicesCount = 0;

        ComposedOf composedOfAnnotation = classToInspect.getAnnotation(ComposedOf.class);
        if (null != composedOfAnnotation) {
            Class<?>[] servicesClasses = composedOfAnnotation.servicesClasses();
            for (Class<?> serviceClass : servicesClasses) {
                totalServicesCount++;

                // Verify if it is a ESECO Workflow Service
                EsecoWorkflowService esecoWorkflowServiceAnnotation = serviceClass.getAnnotation(EsecoWorkflowService.class);
                if(null != esecoWorkflowServiceAnnotation){
                    totalEsecoWorkflowServicesCount++;
                }
            }
        }

        cimm.setServicesCount(totalServicesCount);
        cimm.setEsecoCoreServicesCount(totalServicesCount - totalEsecoWorkflowServicesCount);
        cimm.setEsecoWorkflowServicesCount(totalEsecoWorkflowServicesCount);

        return cimm;
    }

}