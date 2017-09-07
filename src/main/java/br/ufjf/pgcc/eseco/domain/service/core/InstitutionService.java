package br.ufjf.pgcc.eseco.domain.service.core;

import br.ufjf.pgcc.eseco.domain.dao.core.InstitutionDAO;
import br.ufjf.pgcc.eseco.domain.model.core.City;
import br.ufjf.pgcc.eseco.domain.model.core.Country;
import br.ufjf.pgcc.eseco.domain.model.core.Institution;
import br.ufjf.pgcc.eseco.domain.model.core.State;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParseException;
import java.lang.reflect.Type;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class InstitutionService {

    private final InstitutionDAO institutionDAO;

    @Autowired
    public InstitutionService(InstitutionDAO institutionDAO) {
        this.institutionDAO = institutionDAO;
    }

    @Transactional
    public Institution saveOrUpdate(Institution institution) throws Exception {
        if (institution.getId() == 0 || find(institution.getId()) == null) {
            return institutionDAO.add(institution);
        } else {
            return institutionDAO.update(institution);
        }
    }

    @Transactional
    public void delete(Institution institution) throws Exception {
        institutionDAO.delete(institution);
    }

    public Institution find(int institutionId) {
        return institutionDAO.find(institutionId);
    }

    public Institution findByName(String name) {

        if (name != null) {
            Map<String, String> map = new HashMap<>();
            map.put("name", name);
            List<Institution> findBy = institutionDAO.findBy(map);
            return findBy.size() > 0 ? findBy.get(0) : null;
        }
        return null;
    }

    public List<Institution> findAll() {
        return institutionDAO.findAll();
    }

    /**
     * Cria um Json Deserializer para o objeto Institution
     *
     * @param countryService
     * @param stateService
     * @param cityService
     * @param institutionService
     * @return
     */
    public static JsonDeserializer<Institution> getDeserialiser(final CountryService countryService, final StateService stateService,
            final CityService cityService, final InstitutionService institutionService) {
        return new JsonDeserializer() {
            @Override
            public Institution deserialize(JsonElement je, Type type, JsonDeserializationContext jdc) throws JsonParseException {
                Institution i = new Institution();
                JsonObject object = je.getAsJsonObject();
                try {
                    if (object.get("name") != null) {
                        i = institutionService.findByName(object.get("name").getAsString());
                        if (i != null) {
                            return i;
                        } else {
                            i = new Institution();
                        }
                        i.setName(object.get("name").getAsString());

                        Country country = null;
                        if (object.get("country") != null) {
                            country = countryService.findByNameOrCode(object.get("country").getAsString());
                        }

                        State state = null;
                        if (object.get("state") != null) {
                            state = stateService.findByNameOrCode(object.get("state").getAsString());
                            if (state == null) {
                                state = new State(object.get("state").getAsString(), object.get("state").getAsString(), country);
                            }
                        }

                        if (object.get("city") != null && state != null) {

                            City city = cityService.findByNameAndState(object.get("city").getAsString(), state);
                            if (city == null) {
                                city = new City(object.get("city").getAsString(), state);
                                city = cityService.saveOrUpdate(city);
                            }
                            i.setCity(city);
                        }
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                }
                return i;
            }
        };
    }
}
