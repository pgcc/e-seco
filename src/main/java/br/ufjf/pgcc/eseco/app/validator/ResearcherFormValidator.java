package br.ufjf.pgcc.eseco.app.validator;

import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import br.ufjf.pgcc.eseco.domain.service.core.ResearcherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class ResearcherFormValidator implements Validator {

    @Autowired
    private ResearcherService researcherService;

    @Override
    public boolean supports(Class<?> clazz) {
        return Researcher.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {

        Researcher researcher = (Researcher) target;
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "displayName", "NotEmpty.ResearcherForm.displayName");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "institutions", "NotEmpty.ResearcherForm.institutions");
        
        if (researcher.getDisciplines() == null || researcher.getInstitutions().size() < 1) {
            errors.rejectValue("institutions", "Valid.ResearcherForm.institutions");
        }

    }

}
