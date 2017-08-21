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

    @Transactional
    public State find(int stateId) {
        return stateDAO.find(stateId);
    }

    @Transactional(readOnly = true)
    public List<State> findAll() {
        return stateDAO.findAll();
    }

    public List<State> findByName(String name) {
        if (name != null) {
            Map<String, String> map = new HashMap<>();
            map.put("name", name);

            return stateDAO.findBy(map);
        } else {
            return null;
        }
    }
}
