package br.ufjf.pgcc.eseco.app.validator;

import br.ufjf.pgcc.eseco.domain.model.core.Institution;
import br.ufjf.pgcc.eseco.domain.service.core.InstitutionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class InstitutionFormValidator implements Validator {

    @Autowired
    private InstitutionService institutionService;

    @Override
    public boolean supports(Class<?> clazz) {
        return Institution.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {

        Institution institution = (Institution) target;
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "NotEmpty.InstitutionForm.name");

    }

}
