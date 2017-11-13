package br.ufjf.pgcc.eseco.app.validator;

import br.ufjf.pgcc.eseco.domain.model.core.Discipline;
import br.ufjf.pgcc.eseco.domain.service.core.DisciplineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class DisciplineFormValidator implements Validator {

    @Autowired
    private DisciplineService disciplineService;

    @Override
    public boolean supports(Class<?> clazz) {
        return Discipline.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {

        Discipline discipline = (Discipline) target;
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "NotEmpty.DisciplineForm.name");

    }

}
