package br.ufjf.pgcc.eseco.app.validator;

import br.ufjf.pgcc.eseco.domain.model.experiment.Entity;
import br.ufjf.pgcc.eseco.domain.service.experiment.EntityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class ExperimentEntityFormValidator implements Validator {

    @Autowired
    private EntityService entityService;

    @Override
    public boolean supports(Class<?> clazz) {
        return Entity.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {

        Entity entity = (Entity) target;
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "NotEmpty.experimentEntityForm.name");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "kind", "NotEmpty.experimentEntityForm.kind");
    }

}
