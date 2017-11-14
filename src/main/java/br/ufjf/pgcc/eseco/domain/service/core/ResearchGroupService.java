package br.ufjf.pgcc.eseco.domain.service.core;

import br.ufjf.pgcc.eseco.app.service.MendeleyService;
import br.ufjf.pgcc.eseco.domain.dao.core.ResearchGroupDAO;
import br.ufjf.pgcc.eseco.domain.model.core.ResearchGroup;
import static br.ufjf.pgcc.eseco.domain.service.core.DisciplineService.LOGGER;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParseException;
import java.io.IOException;
import java.lang.reflect.Type;
import java.util.HashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

@Service
public class ResearchGroupService {

    private ResearchGroupDAO researchGroupDao;
    private MendeleyService mendeleyService;

    @Autowired
    public ResearchGroupService(ResearchGroupDAO researchGroupDao, MendeleyService mendeleyService) {
        this.researchGroupDao = researchGroupDao;
        this.mendeleyService = mendeleyService;
    }

    public ResearchGroup find(int researchGroupId) {
        return researchGroupDao.find(researchGroupId);
    }

    public List<ResearchGroup> findAll() {
        return researchGroupDao.findAll();
    }

    @Transactional
    public void delete(ResearchGroup researchGroup) throws Exception {
        researchGroupDao.delete(researchGroup);
    }

    @Transactional
    public ResearchGroup saveOrUpdate(ResearchGroup researchGroup) throws Exception {
        if (researchGroup.getId() == 0 || find(researchGroup.getId()) == null) {
            return researchGroupDao.add(researchGroup);
        } else {
            return researchGroupDao.update(researchGroup);
        }
    }

    @Transactional
    public ResearchGroup registerNewResearchGroup(ResearchGroup researchGroup) throws Exception {
        return researchGroupDao.add(researchGroup);
    }

    @Transactional
    public ResearchGroup updateResearchGroup(ResearchGroup researchGroup) throws Exception {
        return researchGroupDao.update(researchGroup);
    }

    @Transactional
    public void populateResearchGroups() {

        try {
            List<ResearchGroup> lista1 = mendeleyService.searchResearchGroups();
        } catch (IOException ex) {
            Logger.getLogger(ResearchGroupService.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (researchGroupDao.findAll().isEmpty()) {
            try {
                List<ResearchGroup> lista = mendeleyService.searchResearchGroups();
                for (ResearchGroup researchGroup : lista) {
                    ResearchGroup savedResearchGroup = new ResearchGroup();

                    Map<String, String> fields = new HashMap<>();
                    fields.put("name", researchGroup.getName());
                    List<ResearchGroup> findBy = researchGroupDao.findBy(fields);

                    if (findBy == null || findBy.isEmpty()) {
                        savedResearchGroup.setName(researchGroup.getName());
                        savedResearchGroup = researchGroupDao.add(savedResearchGroup);
                    } else {
                        savedResearchGroup = findBy.get(0);
                    }
                }

            } catch (Exception ex) {
                LOGGER.log(Level.SEVERE, null, ex);
            }
        }
    }

    /**
     * Cria um Json Deserializer para o objeto Discipline
     *
     * @return
     */
    public static JsonDeserializer<ResearchGroup> getDeserialiser() {
        return new JsonDeserializer() {
            @Override
            public ResearchGroup deserialize(JsonElement je, Type type, JsonDeserializationContext jdc) throws JsonParseException {
                final ResearchGroup rg = new ResearchGroup();
                JsonObject object = je.getAsJsonObject();
                try {

                    if (object.get("name") != null) {
                        rg.setName(object.get("name").getAsString());
                    }

                    if (object.get("description") != null) {
                        rg.setDescription(object.get("description").getAsString());
                    }

                    if (object.get("web_page") != null) {
                        rg.setWebPage(object.get("web_page").getAsString());
                    }

//                    if (object.get("disciplines") != null) {
//                        List<Discipline> subdisciplines = new ArrayList<>();
//                        JsonArray jsonArray = object.get("disciplines").getAsJsonArray();
//                        for (JsonElement jsonElement : jsonArray) {
//                            JsonObject obj = jsonElement.getAsJsonObject();
//                            if (obj.get("name") != null) {
//                                Discipline s = new Discipline();
//                                s.setName(obj.get("name").getAsString());
//                                subdisciplines.add(s);
//                            }
//                        }
//                        rg.setDisciplines(subdisciplines);
//                    }
                } catch (Exception e) {
                    LOGGER.log(Level.SEVERE, null, e);
                }
                return rg;
            }
        };
    }

}
