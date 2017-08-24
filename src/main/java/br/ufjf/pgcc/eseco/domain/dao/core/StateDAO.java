/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufjf.pgcc.eseco.domain.dao.core;

import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import br.ufjf.pgcc.eseco.domain.model.core.City;
import br.ufjf.pgcc.eseco.domain.model.core.Country;
import br.ufjf.pgcc.eseco.domain.model.core.State;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Lenita
 */
@Repository
public class StateDAO extends CommonDAO<State, Integer> {

    public StateDAO() {
        super(State.class);
    }

    public void populateBrazilStates(CountryDAO countryDAO, CityDAO cityDAO) throws Exception {
        Map<String, String> map = new HashMap<>();
        map.put("name", "Brazil");

        List<Country> findBy = countryDAO.findBy(map);

        Country brazil = findBy.get(0);

        if (brazil != null) {
            State s = add(new State("Acre", "AC", brazil));
            s.setCapital(cityDAO.add(new City("Rio Branco", s)));
            update(s);
            s = add(new State("Alagoas", "AL", brazil));
            s.setCapital(cityDAO.add(new City("Maceió", s)));
            update(s);
            s = add(new State("Amapá", "AP", brazil));
            s.setCapital(cityDAO.add(new City("Macapá", s)));
            update(s);
            s = add(new State("Amazonas", "AM", brazil));
            s.setCapital(cityDAO.add(new City("Manaus", s)));
            update(s);
            s = add(new State("Bahia", "BA", brazil));
            s.setCapital(cityDAO.add(new City("Salvador", s)));
            update(s);
            s = add(new State("Ceará", "CE", brazil));
            s.setCapital(cityDAO.add(new City("Fortaleza", s)));
            update(s);
            s = add(new State("Distrito Federal", "DF", brazil));
            s.setCapital(cityDAO.add(new City("Brasília", s)));
            update(s);
            s = add(new State("Espírito Santo", "ES", brazil));
            s.setCapital(cityDAO.add(new City("Vitória", s)));
            update(s);
            s = add(new State("Goiás", "GO", brazil));
            s.setCapital(cityDAO.add(new City("Goiânia", s)));
            update(s);
            s = add(new State("Maranhão", "MA", brazil));
            s.setCapital(cityDAO.add(new City("São Luís", s)));
            update(s);
            s = add(new State("Mato Grosso", "MT", brazil));
            s.setCapital(cityDAO.add(new City("Cuiabá", s)));
            update(s);
            s = add(new State("Mato Grosso do Sul", "MS", brazil));
            s.setCapital(cityDAO.add(new City("Campo Grande", s)));
            update(s);
            s = add(new State("Minas Gerais", "MG", brazil));
            s.setCapital(cityDAO.add(new City("Belo Horizonte", s)));
            update(s);
            s = add(new State("Pará", "PA", brazil));
            s.setCapital(cityDAO.add(new City("Belém", s)));
            update(s);
            s = add(new State("Paraíba", "PB", brazil));
            s.setCapital(cityDAO.add(new City("João Pessoa", s)));
            update(s);
            s = add(new State("Paraná", "PR", brazil));
            s.setCapital(cityDAO.add(new City("Curitiba", s)));
            update(s);
            s = add(new State("Pernambuco", "PE", brazil));
            s.setCapital(cityDAO.add(new City("Recife", s)));
            update(s);
            s = add(new State("Piauí", "PI", brazil));
            s.setCapital(cityDAO.add(new City("Teresina", s)));
            update(s);
            s = add(new State("Rio de Janeiro", "RJ", brazil));
            s.setCapital(cityDAO.add(new City("Rio de Janeiro", s)));
            update(s);
            s = add(new State("Rio Grande do Norte", "RN", brazil));
            s.setCapital(cityDAO.add(new City("Natal", s)));
            update(s);
            s = add(new State("Rio Grande do Sul", "RS", brazil));
            s.setCapital(cityDAO.add(new City("Porto Alegre", s)));
            update(s);
            s = add(new State("Rondônia", "RO", brazil));
            s.setCapital(cityDAO.add(new City("Porto Velho", s)));
            update(s);
            s = add(new State("Roraima", "RR", brazil));
            s.setCapital(cityDAO.add(new City("Boa Vista", s)));
            update(s);
            s = add(new State("Santa Catarina", "SC", brazil));
            s.setCapital(cityDAO.add(new City("Florianópolis", s)));
            update(s);
            s = add(new State("São Paulo", "SP", brazil));
            s.setCapital(cityDAO.add(new City("São Paulo", s)));
            update(s);
            s = add(new State("Sergipe", "SE", brazil));
            s.setCapital(cityDAO.add(new City("Aracaju", s)));
            update(s);
            s = add(new State("Tocantins", "TO", brazil));
            s.setCapital(cityDAO.add(new City("Palmas", s)));
            update(s);
        }

    }

}
