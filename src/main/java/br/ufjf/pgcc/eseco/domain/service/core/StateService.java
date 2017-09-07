package br.ufjf.pgcc.eseco.domain.service.core;

import br.ufjf.pgcc.eseco.domain.dao.core.CityDAO;
import br.ufjf.pgcc.eseco.domain.dao.core.CountryDAO;
import br.ufjf.pgcc.eseco.domain.dao.core.StateDAO;
import br.ufjf.pgcc.eseco.domain.model.core.City;
import br.ufjf.pgcc.eseco.domain.model.core.Country;
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

    @Transactional
    public void populateBrazilStates() {
        if (stateDAO.findAll().isEmpty()) {
            try {
                Map<String, String> map = new HashMap<>();
                map.put("name", "Brazil");

                List<Country> findBy = countryDAO.findBy(map);

                Country brazil = findBy.get(0);

                if (brazil != null) {
                    State s = stateDAO.add(new State("Acre", "AC", brazil));
                    s.setCapital(cityDAO.add(new City("Rio Branco", s)));
                    stateDAO.update(s);
                    s = stateDAO.add(new State("Alagoas", "AL", brazil));
                    s.setCapital(cityDAO.add(new City("Maceió", s)));
                    stateDAO.update(s);
                    s = stateDAO.add(new State("Amapá", "AP", brazil));
                    s.setCapital(cityDAO.add(new City("Macapá", s)));
                    stateDAO.update(s);
                    s = stateDAO.add(new State("Amazonas", "AM", brazil));
                    s.setCapital(cityDAO.add(new City("Manaus", s)));
                    stateDAO.update(s);
                    s = stateDAO.add(new State("Bahia", "BA", brazil));
                    s.setCapital(cityDAO.add(new City("Salvador", s)));
                    stateDAO.update(s);
                    s = stateDAO.add(new State("Ceará", "CE", brazil));
                    s.setCapital(cityDAO.add(new City("Fortaleza", s)));
                    stateDAO.update(s);
                    s = stateDAO.add(new State("Distrito Federal", "DF", brazil));
                    s.setCapital(cityDAO.add(new City("Brasília", s)));
                    stateDAO.update(s);
                    s = stateDAO.add(new State("Espírito Santo", "ES", brazil));
                    s.setCapital(cityDAO.add(new City("Vitória", s)));
                    stateDAO.update(s);
                    s = stateDAO.add(new State("Goiás", "GO", brazil));
                    s.setCapital(cityDAO.add(new City("Goiânia", s)));
                    stateDAO.update(s);
                    s = stateDAO.add(new State("Maranhão", "MA", brazil));
                    s.setCapital(cityDAO.add(new City("São Luís", s)));
                    stateDAO.update(s);
                    s = stateDAO.add(new State("Mato Grosso", "MT", brazil));
                    s.setCapital(cityDAO.add(new City("Cuiabá", s)));
                    stateDAO.update(s);
                    s = stateDAO.add(new State("Mato Grosso do Sul", "MS", brazil));
                    s.setCapital(cityDAO.add(new City("Campo Grande", s)));
                    stateDAO.update(s);
                    s = stateDAO.add(new State("Minas Gerais", "MG", brazil));
                    s.setCapital(cityDAO.add(new City("Belo Horizonte", s)));
                    stateDAO.update(s);
                    s = stateDAO.add(new State("Pará", "PA", brazil));
                    s.setCapital(cityDAO.add(new City("Belém", s)));
                    stateDAO.update(s);
                    s = stateDAO.add(new State("Paraíba", "PB", brazil));
                    s.setCapital(cityDAO.add(new City("João Pessoa", s)));
                    stateDAO.update(s);
                    s = stateDAO.add(new State("Paraná", "PR", brazil));
                    s.setCapital(cityDAO.add(new City("Curitiba", s)));
                    stateDAO.update(s);
                    s = stateDAO.add(new State("Pernambuco", "PE", brazil));
                    s.setCapital(cityDAO.add(new City("Recife", s)));
                    stateDAO.update(s);
                    s = stateDAO.add(new State("Piauí", "PI", brazil));
                    s.setCapital(cityDAO.add(new City("Teresina", s)));
                    stateDAO.update(s);
                    s = stateDAO.add(new State("Rio de Janeiro", "RJ", brazil));
                    s.setCapital(cityDAO.add(new City("Rio de Janeiro", s)));
                    stateDAO.update(s);
                    s = stateDAO.add(new State("Rio Grande do Norte", "RN", brazil));
                    s.setCapital(cityDAO.add(new City("Natal", s)));
                    stateDAO.update(s);
                    s = stateDAO.add(new State("Rio Grande do Sul", "RS", brazil));
                    s.setCapital(cityDAO.add(new City("Porto Alegre", s)));
                    stateDAO.update(s);
                    s = stateDAO.add(new State("Rondônia", "RO", brazil));
                    s.setCapital(cityDAO.add(new City("Porto Velho", s)));
                    stateDAO.update(s);
                    s = stateDAO.add(new State("Roraima", "RR", brazil));
                    s.setCapital(cityDAO.add(new City("Boa Vista", s)));
                    stateDAO.update(s);
                    s = stateDAO.add(new State("Santa Catarina", "SC", brazil));
                    s.setCapital(cityDAO.add(new City("Florianópolis", s)));
                    stateDAO.update(s);
                    s = stateDAO.add(new State("São Paulo", "SP", brazil));
                    s.setCapital(cityDAO.add(new City("São Paulo", s)));
                    stateDAO.update(s);
                    s = stateDAO.add(new State("Sergipe", "SE", brazil));
                    s.setCapital(cityDAO.add(new City("Aracaju", s)));
                    stateDAO.update(s);
                    s = stateDAO.add(new State("Tocantins", "TO", brazil));
                    s.setCapital(cityDAO.add(new City("Palmas", s)));
                    stateDAO.update(s);
                }
            } catch (Exception ex) {
                Logger.getLogger(StateService.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

}
