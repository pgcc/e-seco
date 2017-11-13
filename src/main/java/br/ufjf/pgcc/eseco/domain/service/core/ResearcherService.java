package br.ufjf.pgcc.eseco.domain.service.core;

import br.ufjf.pgcc.eseco.domain.dao.core.ResearcherDAO;
import br.ufjf.pgcc.eseco.domain.model.core.Discipline;
import br.ufjf.pgcc.eseco.domain.model.core.Institution;
import br.ufjf.pgcc.eseco.domain.model.core.Interest;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
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
import java.util.logging.Level;
import java.util.logging.Logger;

@Service
public class ResearcherService {

    private static final Logger LOGGER = Logger.getLogger(ResearcherService.class.getName());

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

    public Researcher findByKeplerId(String keplerId) {
        if (keplerId != null) {
            Map<String, String> map = new HashMap<>();
            map.put("keplerId", keplerId);
            List<Researcher> findBy = researcherDAO.findBy(map);
            return findBy.size() > 0 ? findBy.get(0) : null;
        }
        return null;

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

                    if (object.get("research_interests_list") != null) {
                        JsonArray jsonArray = object.get("research_interests_list").getAsJsonArray();
                        List<Interest> interests = new ArrayList<>();
                        for (JsonElement jsonElement : jsonArray) {
                            Interest i = new Interest();
                            i.setName(jsonElement.getAsString());
                            interests.add(i);
                        }
                        r.setResearchInterests(interests);
                    }

                    if (object.get("academic_status") != null) {
                        r.setAcademicStatus(object.get("academic_status").getAsString());
                    }

                    if (object.get("disciplines") != null) {
                        List<Discipline> disciplines = new ArrayList<>();
                        JsonArray jsonArray = object.get("disciplines").getAsJsonArray();
                        for (JsonElement jsonElement : jsonArray) {
                            JsonObject obj = jsonElement.getAsJsonObject();
                            if (obj.get("name") != null) {
                                Discipline s = new Discipline();
                                s.setName(obj.get("name").getAsString());
                                disciplines.add(s);
                            }
                        }
                        r.setDisciplines(disciplines);
                    }

                    if (object.get("photo") != null && object.get("photo").getAsJsonObject().get("original") != null) {
                        r.setPhoto(object.get("photo").getAsJsonObject().get("original").getAsString());
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
                    LOGGER.log(Level.SEVERE, null, e);
                }
                return r;
            }
        };
    }
}
