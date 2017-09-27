package br.ufjf.pgcc.eseco.domain.service.core;

import br.ufjf.pgcc.eseco.domain.dao.core.ResearcherDAO;
import br.ufjf.pgcc.eseco.domain.model.core.Institution;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
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
public class ResearcherService {

    private final ResearcherDAO researcherDAO;

    @Autowired
    public ResearcherService(ResearcherDAO researcherDAO) {
        this.researcherDAO = researcherDAO;
    }

    @Transactional
    public Researcher saveOrUpdate(Researcher researcher) throws Exception {
        if (researcher.isNew()) {
            return researcherDAO.add(researcher);
        } else {
            return researcherDAO.update(researcher);
        }
    }

    @Transactional
    public void delete(Researcher researcher) throws Exception {
        researcherDAO.delete(researcher);
    }

    public Researcher find(int researcherId) {
        return researcherDAO.find(researcherId);
    }

    public List<Researcher> findAll() {
        return researcherDAO.findAll();
    }

    /**
     * Cria um Json Deserializer para o objeto Researcher
     *
     * @param countryService
     * @param stateService
     * @param cityService
     * @param institutionService
     * @return
     */
    public static JsonDeserializer<Researcher> getDeserialiser(final CountryService countryService, final StateService stateService,
            final CityService cityService, final InstitutionService institutionService) {
        return new JsonDeserializer() {
            @Override
            public Researcher deserialize(JsonElement je, Type type, JsonDeserializationContext jdc) throws JsonParseException {
                final Researcher r = new Researcher();
                JsonObject object = je.getAsJsonObject();
                try {
                    if (object.get("id") != null) {
                        r.setMendeleyId(object.get("id").getAsString());
                    }

                    if (object.get("display_name") != null) {
                        r.setDisplayName(object.get("display_name").getAsString());
                    }

                    if (object.get("title") != null) {
                        r.setTitle(object.get("title").getAsString());
                    }

                    if (object.get("academic_status") != null) {
                        r.setAcademicStatus(object.get("academic_status").getAsString());
                    }

                    if (object.get("institution") != null) {
                        ArrayList<Institution> institutionsList = new ArrayList<>();
                        if (object.get("institution_details") != null) {
                            GsonBuilder gsonBuilder = new GsonBuilder();
                            gsonBuilder.registerTypeAdapter(Institution.class, InstitutionService.getDeserialiser(
                                    countryService, stateService, cityService, institutionService));
                            JsonElement institutionElement = object.get("institution_details");
                            Gson gson = gsonBuilder.create();
                            Institution institution = gson.fromJson(institutionElement, Institution.class);
                            institutionsList.add(institution);
                        }

                        r.setInstitutions(institutionsList);
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                }
                return r;
            }
        };
    }
}
