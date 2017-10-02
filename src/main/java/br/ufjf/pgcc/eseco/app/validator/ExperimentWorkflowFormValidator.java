package br.ufjf.pgcc.eseco.app.validator;

import br.ufjf.pgcc.eseco.domain.model.experiment.Workflow;
import br.ufjf.pgcc.eseco.domain.service.experiment.WorkflowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class ExperimentWorkflowFormValidator implements Validator {

    @Autowired
    WorkflowService workflowService;

    @Override
    public boolean supports(Class<?> clazz) {
        return Workflow.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {

        Workflow workflow = (Workflow) target;
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "NotEmpty.experimentWorkflowForm.name");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "description", "NotEmpty.experimentWorkflowForm.description");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "version", "NotEmpty.experimentWorkflowForm.version");

    }

}
