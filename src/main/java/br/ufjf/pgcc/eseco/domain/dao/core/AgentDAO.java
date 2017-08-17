package br.ufjf.pgcc.eseco.domain.dao.core;

import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import br.ufjf.pgcc.eseco.domain.model.core.Agent;
import org.springframework.stereotype.Repository;

@Repository
public class AgentDAO extends CommonDAO<Agent, Integer> {

    protected AgentDAO() {
        super(Agent.class);
    }
}