package br.ufjf.pgcc.eseco.domain.service.core;

import br.ufjf.pgcc.eseco.domain.dao.core.CityDAO;
import br.ufjf.pgcc.eseco.domain.dao.core.CountryDAO;
import br.ufjf.pgcc.eseco.domain.dao.core.StateDAO;
import br.ufjf.pgcc.eseco.domain.model.core.State;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

@Service
public class StateService {

    private final StateDAO stateDAO;
    private final CountryDAO countryDAO;
    private final CityDAO cityDAO;

    @Autowired
    public StateService(StateDAO stateDao, CountryDAO countryDAO, CityDAO cityDAO) {
        this.stateDAO = stateDao;
        this.countryDAO = countryDAO;
        this.cityDAO = cityDAO;
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

    @Transactional(readOnly = true)
    public List<State> findByName(String name) {
        if (name != null) {
            Map<String, String> map = new HashMap<>();
            map.put("name", name);

            return stateDAO.findBy(map);
        } else {
            return null;
        }
    }

    @Transactional
    public void populateBrazilStates() {
        if (stateDAO.findAll().isEmpty()) {
            try {
                stateDAO.populateBrazilStates(countryDAO, cityDAO);
            } catch (Exception ex) {
                Logger.getLogger(StateService.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
