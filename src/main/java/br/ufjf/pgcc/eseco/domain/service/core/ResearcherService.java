package br.ufjf.pgcc.eseco.domain.service.core;

import br.ufjf.pgcc.eseco.domain.dao.core.ResearcherDAO;
import br.ufjf.pgcc.eseco.domain.model.core.Institution;
import br.ufjf.pgcc.eseco.domain.model.core.Researcher;
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
    public ResearcherService(ResearcherDAO researcherDao) {
        this.researcherDAO = researcherDao;
    }

    @Transactional
    public Researcher saveOrUpdate(Researcher researcher) throws Exception {
        if (researcher.getId() == 0 || find(researcher.getId()) == null) {
            return researcherDAO.add(researcher);
        } else {
            return researcherDAO.update(researcher);
        }
    }

    @Transactional
    public Researcher registerNewResearcher(Researcher researcher) throws Exception {

        researcher = researcherDAO.add(researcher);

        return researcher;
    }

    @Transactional
    public void delete(Researcher researcher) throws Exception {
        researcherDAO.delete(researcher);
    }

    @Transactional
    public Researcher find(int researcherId) {
        return researcherDAO.find(researcherId);
    }

    @Transactional(readOnly = true)
    public List<Researcher> findAll() {
        return researcherDAO.findAll();
    }

    /**
     * Cria um Json Deserializer para o objeto Researcher
     *
     * @return
     */
    public static JsonDeserializer<Researcher> getDeserialiser() {
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
                        Institution institution = new Institution();
                        institution.setName(object.get("institution").getAsString());
                        if (object.get("institution_details") != null) {
                            //  institution.setDetails(object.get("institution_details").getAsString());
                        }
                        r.setInstitution(institution);
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                }
                return r;
            }
        };
    }
}
