package br.ufjf.pgcc.eseco.domain.service.core;

import br.ufjf.pgcc.eseco.domain.dao.core.DisciplineDAO;
import br.ufjf.pgcc.eseco.domain.model.core.Discipline;
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
public class DisciplineService {

    private final DisciplineDAO disciplineDAO;

    static final Logger LOGGER = Logger.getLogger(DisciplineService.class.getName());

    @Autowired
    public DisciplineService(DisciplineDAO disciplineDAO) {
        this.disciplineDAO = disciplineDAO;
    }

    @Transactional
    public Discipline saveOrUpdate(Discipline discipline) throws Exception {
        if (discipline.getId() == 0 || find(discipline.getId()) == null) {
            return disciplineDAO.add(discipline);
        } else {
            return disciplineDAO.update(discipline);
        }
    }

    @Transactional
    public void delete(Discipline discipline) throws Exception {
        disciplineDAO.delete(discipline);
    }

    public Discipline find(int disciplineId) {
        return disciplineDAO.find(disciplineId);
    }

    public Discipline findByName(String name) {
        if (name != null) {
            Map<String, String> map = new HashMap<>();
            map.put("name", name);
            List<Discipline> findBy = disciplineDAO.findBy(map);
            return findBy.size() > 0 ? findBy.get(0) : null;
        }
        return null;
    }

    public List<Discipline> findAll() {
        return disciplineDAO.findAll();
    }

    /**
     * Cria um Json Deserializer para o objeto Discipline
     *
     * @return Json Deserializer para o objeto Discipline
     */
    public static JsonDeserializer<Discipline> getDeserialiser() {
        return new JsonDeserializer() {
            @Override
            public Discipline deserialize(JsonElement je, Type type, JsonDeserializationContext jdc) throws JsonParseException {
                final Discipline d = new Discipline();
                JsonObject object = je.getAsJsonObject();
                try {

                    if (object.get("name") != null) {
                        d.setName(object.get("name").getAsString());
                    }

                    if (object.get("subdisciplines") != null) {
                        List<Discipline> subdisciplines = new ArrayList<>();
                        JsonArray jsonArray = object.get("subdisciplines").getAsJsonArray();
                        for (JsonElement jsonElement : jsonArray) {
                            JsonObject obj = jsonElement.getAsJsonObject();
                            if (obj.get("name") != null) {
                                Discipline s = new Discipline();
                                s.setName(obj.get("name").getAsString());
                                subdisciplines.add(s);
                            }
                        }
                        d.setSubdisciplines(subdisciplines);
                    }

                } catch (Exception e) {
                    LOGGER.log(Level.SEVERE, null, e);
                }
                return d;
            }
        };
    }

}
