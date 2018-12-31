package br.ufjf.pgcc.eseco.domain.service.core;

import br.ufjf.pgcc.eseco.domain.dao.core.StateDAO;
import br.ufjf.pgcc.eseco.domain.model.core.State;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class StateService {

    private final StateDAO stateDAO;

    @Autowired
    public StateService(StateDAO stateDao) {
        this.stateDAO = stateDao;
    }

    @Transactional
    public State saveOrUpdate(State state) throws Exception {
        if (state.getId() == 0 || find(state.getId()) == null) {
            return stateDAO.add(state);
        } else {
            return stateDAO.update(state);
        }
    }

    @Transactional
    public State registerNewState(State state) throws Exception {

        state = stateDAO.add(state);

        return state;
    }

    @Transactional
    public void delete(State state) throws Exception {
        stateDAO.delete(state);
    }

    public State find(int stateId) {
        return stateDAO.find(stateId);
    }

    public List<State> findAll() {
        return stateDAO.findAll();
    }

    public State findByNameOrCode(String name) {
        if (name != null) {
            Map<String, String> map = new HashMap<>();
            map.put("name", name);
            List<State> findBy = stateDAO.findBy(map);
            if (findBy.size() <= 0) {
                map = new HashMap<>();
                map.put("code", name);
                findBy = stateDAO.findBy(map);
            }
            return findBy.size() > 0 ? findBy.get(0) : null;
        }
        return null;

    }

}
