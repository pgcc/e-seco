package br.ufjf.pgcc.eseco.app.validator;

import br.ufjf.pgcc.eseco.domain.model.core.ResearchGroup;
import br.ufjf.pgcc.eseco.domain.service.core.ResearchGroupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class ResearchGroupFormValidator implements Validator {

    @Autowired
    private ResearchGroupService researchGroupService;

    @Override
    public boolean supports(Class<?> clazz) {
        return ResearchGroup.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {

        ResearchGroup researchGroup = (ResearchGroup) target;
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "NotEmpty.ResearchGroupForm.name");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "members", "NotEmpty.ResearchGroupForm.members");

        if (researchGroup.getMembers() == null || researchGroup.getMembers().size() < 1) {
            errors.rejectValue("members", "Valid.ResearchGroupForm.members");
        }
    }

}
