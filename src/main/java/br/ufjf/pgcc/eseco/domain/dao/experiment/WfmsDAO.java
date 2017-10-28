/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.domain.dao.experiment;

import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.Wfms;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Lenita
 */
@Repository
public class WfmsDAO extends CommonDAO<Wfms, Integer> {

    protected WfmsDAO() {
        super(Wfms.class);
    }
}
