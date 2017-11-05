package br.ufjf.pgcc.eseco.app.validator;

import br.ufjf.pgcc.eseco.domain.model.experiment.Activity;
import br.ufjf.pgcc.eseco.domain.service.experiment.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class ExperimentActivityFormValidator implements Validator {

    @Autowired
    private ActivityService activityService;

    @Override
    public boolean supports(Class<?> clazz) {
        return Activity.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {

        Activity activity = (Activity) target;
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "NotEmpty.experimentActivityForm.name");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "description", "NotEmpty.experimentActivityForm.description");

    }

}
