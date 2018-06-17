/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.domain.dao.experiment;

import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.Port;
import java.util.Map;
import javax.persistence.NoResultException;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Lenita
 */
@Repository
public class PortDAO extends CommonDAO<Port, Integer> {

    protected PortDAO() {
        super(Port.class);
    }

    /**
     * Find a Port by Entity id
     *
     * @param entityId
     * @return
     */
    public Port findOneByEntityId(int entityId) {

        StringBuilder sb = new StringBuilder();
        sb.append("select p from Port p ");
        sb.append("join p.entity as e ");
        sb.append("where e.id = :entityId ");

        Query q = this.em.createQuery(sb.toString(), entityClass);
        q.setParameter("entityId", entityId);
        
        try {
            return (Port) q.getSingleResult();
        } catch (NoResultException nre) {
            return null;
        }
    }
}
