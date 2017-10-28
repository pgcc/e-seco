package br.ufjf.pgcc.eseco.app.validator;

import br.ufjf.pgcc.eseco.domain.model.experiment.Experiment;
import br.ufjf.pgcc.eseco.domain.service.experiment.ExperimentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class ExperimentFormValidator implements Validator {

    @Autowired
    @Qualifier("emailValidator")
    EmailValidator emailValidator;

    @Autowired
    ExperimentService experimentService;

    @Override
    public boolean supports(Class<?> clazz) {
        return Experiment.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {

        Experiment experiment = (Experiment) target;

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "NotEmpty.experimentForm.name");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "description", "NotEmpty.experimentForm.description");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "disciplines", "NotEmpty.experimentForm.disciplines");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "keywords", "NotEmpty.experimentForm.keywords");

        if (experiment.getDisciplines() == null || experiment.getDisciplines().size() < 1) {
            errors.rejectValue("disciplines", "Valid.experimentForm.disciplines");
        }

    }

}
