package br.ufjf.pgcc.eseco.domain.service.core;

import br.ufjf.pgcc.eseco.domain.dao.core.InstitutionDAO;
import br.ufjf.pgcc.eseco.domain.model.core.Institution;
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

    @Transactional
    public Institution find(int institutionId) {
        return institutionDAO.find(institutionId);
    }

    @Transactional(readOnly = true)
    public List<Institution> findAll() {
        return institutionDAO.findAll();
    }

    /**
     * Cria um Json Deserializer para o objeto Institution
     *
     * @return
     */
    public static JsonDeserializer<Institution> getDeserialiser() {
        return new JsonDeserializer() {
            @Override
            public Institution deserialize(JsonElement je, Type type, JsonDeserializationContext jdc) throws JsonParseException {
                final Institution i = new Institution();
                JsonObject object = je.getAsJsonObject();
                try {
                    if (object.get("name") != null) {
                        i.setName(object.get("name").getAsString());
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                }
                return i;
            }
        };
    }
}
