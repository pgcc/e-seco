package br.ufjf.pgcc.eseco.domain.service.core;

import br.ufjf.pgcc.eseco.domain.dao.core.AgentDAO;
import br.ufjf.pgcc.eseco.domain.model.core.Agent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class AgentService {

    private AgentDAO agentDao;

    @Autowired
    public AgentService(AgentDAO agentDao) {
        this.agentDao = agentDao;
    }

    public Agent find(int agentId) {
        return agentDao.find(agentId);
    }

    public List<Agent> findAll() {
        return agentDao.findAll();
    }

    @Transactional
    public Agent registerNewAgent(Agent agent) throws Exception {
        return agentDao.add(agent);
    }

    @Transactional
    public Agent updateAgent(Agent agent) throws Exception {
        return agentDao.update(agent);
    }
}
