package br.ufjf.pgcc.eseco.app.validator;

import br.ufjf.pgcc.eseco.domain.model.experiment.DetailGroup;
import br.ufjf.pgcc.eseco.domain.service.experiment.DetailGroupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class DetailGroupFormValidator implements Validator {

    @Autowired
    private DetailGroupService detailGroupService;

    @Override
    public boolean supports(Class<?> clazz) {
        return DetailGroup.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {

        DetailGroup detailGroup = (DetailGroup) target;
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "NotEmpty.DetailGroupForm.name");        
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "details", "NotEmpty.DetailGroupForm.details");

    }

}
