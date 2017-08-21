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

    public void populateBrazlStates() throws Exception {
        Map<String, String> map = new HashMap<>();
        map.put("name", "Brazil");

        List<Country> findBy = new CountryDAO().findBy(map);

        Country brazil = findBy.get(0);

        if (brazil != null) {
            State s = add(new State("Acre", "AC", brazil));
            s.setCapital(new City("Rio Branco", s));
            s = add(new State("Alagoas", "AL", brazil));
            s.setCapital(new City("Maceió", s));
            s = add(new State("Amapá", "AP", brazil));
            s.setCapital(new City("Macapá", s));
            s = add(new State("Amazonas", "AM", brazil));
            s.setCapital(new City("Manaus", s));
            s = add(new State("Bahia", "BA", brazil));
            s.setCapital(new City("Salvador", s));
            s = add(new State("Ceará", "CE", brazil));
            s.setCapital(new City("Fortaleza", s));
            s = add(new State("Distrito Federal", "DF", brazil));
            s.setCapital(new City("Brasília", s));
            s = add(new State("Espírito Santo", "ES", brazil));
            s.setCapital(new City("Vitória", s));
            s = add(new State("Goiás", "GO", brazil));
            s.setCapital(new City("Goiânia", s));
            s = add(new State("Maranhão", "MA", brazil));
            s.setCapital(new City("São Luís", s));
            s = add(new State("Mato Grosso", "MT", brazil));
            s.setCapital(new City("Cuiabá", s));
            s = add(new State("Mato Grosso do Sul", "MS", brazil));
            s.setCapital(new City("Campo Grande", s));
            s = add(new State("Minas Gerais", "MG", brazil));
            s.setCapital(new City("Belo Horizonte", s));
            s = add(new State("Pará", "PA", brazil));
            s.setCapital(new City("Belém", s));
            s = add(new State("Paraíba", "PB", brazil));
            s.setCapital(new City("João Pessoa", s));
            s = add(new State("Paraná", "PR", brazil));
            s.setCapital(new City("Curitiba", s));
            s = add(new State("Pernambuco", "PE", brazil));
            s.setCapital(new City("Recife", s));
            s = add(new State("Piauí", "PI", brazil));
            s.setCapital(new City("Teresina", s));
            s = add(new State("Rio de Janeiro", "RJ", brazil));
            s.setCapital(new City("Rio de Janeiro", s));
            s = add(new State("Rio Grande do Norte", "RN", brazil));
            s.setCapital(new City("Natal", s));
            s = add(new State("Rio Grande do Sul", "RS", brazil));
            s.setCapital(new City("Porto Alegre", s));
            s = add(new State("Rondônia", "RO", brazil));
            s.setCapital(new City("Porto Velho", s));
            s = add(new State("Roraima", "RR", brazil));
            s.setCapital(new City("Boa Vista", s));
            s = add(new State("Santa Catarina", "SC", brazil));
            s.setCapital(new City("Florianópolis", s));
            s = add(new State("São Paulo", "SP", brazil));
            s.setCapital(new City("São Paulo", s));
            s = add(new State("Sergipe", "SE", brazil));
            s.setCapital(new City("Aracaju", s));
            s = add(new State("Tocantins", "TO", brazil));
            s.setCapital(new City("Palmas", s));
        }

    }
}
