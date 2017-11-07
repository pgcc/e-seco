package br.ufjf.pgcc.eseco.app.validator;

import br.ufjf.pgcc.eseco.domain.model.experiment.WorkflowExecution;
import br.ufjf.pgcc.eseco.domain.service.experiment.WorkflowExecutionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class ExperimentWorkflowExecutionFormValidator implements Validator {

    @Autowired
    private WorkflowExecutionService workflowExecutionService;

    @Override
    public boolean supports(Class<?> clazz) {
        return WorkflowExecution.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {

        WorkflowExecution workflowExecution = (WorkflowExecution) target;
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "workflow", "NotEmpty.experimentWorkflowExecutionForm.workflow");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "author", "NotEmpty.experimentWorkflowExecutionForm.author");

    }

}
