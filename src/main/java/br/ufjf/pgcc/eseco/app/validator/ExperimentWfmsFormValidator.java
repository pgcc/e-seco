package br.ufjf.pgcc.eseco.app.validator;

import br.ufjf.pgcc.eseco.domain.model.experiment.Wfms;
import br.ufjf.pgcc.eseco.domain.service.experiment.WfmsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class ExperimentWfmsFormValidator implements Validator {

    @Autowired
    private WfmsService wfmsService;

    @Override
    public boolean supports(Class<?> clazz) {
        return Wfms.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {

        Wfms wfms = (Wfms) target;
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "NotEmpty.experimentWfmsForm.name");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "link", "NotEmpty.experimentWfmsForm.link");

    }

}
