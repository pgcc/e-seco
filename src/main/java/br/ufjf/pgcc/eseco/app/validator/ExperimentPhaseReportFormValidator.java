package br.ufjf.pgcc.eseco.app.validator;

import br.ufjf.pgcc.eseco.domain.model.experiment.ExperimentPhaseReport;
import br.ufjf.pgcc.eseco.domain.service.experiment.ExperimentPhaseReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class ExperimentPhaseReportFormValidator implements Validator {


    @Autowired
    private ExperimentPhaseReportService experimentPhaseReportService;

    @Override
    public boolean supports(Class<?> clazz) {
        return ExperimentPhaseReport.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {

        ExperimentPhaseReport experimentPhaseReport = (ExperimentPhaseReport) target;
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "description", "NotEmpty.experimentPhaseReportForm.description");


    }

}
