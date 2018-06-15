package br.ufjf.pgcc.eseco.app.validator;

import br.ufjf.pgcc.eseco.domain.model.experiment.ActivityExecution;
import br.ufjf.pgcc.eseco.domain.service.experiment.ActivityExecutionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class ExperimentActivityExecutionFormValidator implements Validator {

    @Autowired
    private ActivityExecutionService activityExecutionService;

    @Override
    public boolean supports(Class<?> clazz) {
        return ActivityExecution.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {

        ActivityExecution activityExecution = (ActivityExecution) target;
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "activity", "NotEmpty.experimentActivityExecutionForm.activity");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "author", "NotEmpty.experimentActivityExecutionForm.author");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "startTime", "NotEmpty.experimentActivityExecutionForm.endTime");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "endTime", "NotEmpty.experimentActivityExecutionForm.endTime");

    }

}
