/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.domain.dao.core;

import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import br.ufjf.pgcc.eseco.domain.model.core.Interest;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Lenita
 */
@Repository
public class InterestDAO extends CommonDAO<Interest, Integer> {

    protected InterestDAO() {
        super(Interest.class);
    }
}
