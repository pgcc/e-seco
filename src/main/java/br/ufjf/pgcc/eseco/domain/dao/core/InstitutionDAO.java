package br.ufjf.pgcc.eseco.domain.dao.core;

import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import br.ufjf.pgcc.eseco.domain.model.core.Institution;
import org.springframework.stereotype.Repository;

@Repository
public class InstitutionDAO extends CommonDAO<Institution, Integer> {

    protected InstitutionDAO() {
        super(Institution.class);
    }
}
