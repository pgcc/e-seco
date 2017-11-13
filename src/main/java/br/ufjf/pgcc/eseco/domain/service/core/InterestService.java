package br.ufjf.pgcc.eseco.domain.service.core;

import br.ufjf.pgcc.eseco.app.service.MendeleyService;
import br.ufjf.pgcc.eseco.domain.dao.core.InterestDAO;
import br.ufjf.pgcc.eseco.domain.model.core.Interest;
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
public class InterestService {

    private final MendeleyService mendeleyService;
    private final InterestDAO interestDAO;

    static final Logger LOGGER = Logger.getLogger(InterestService.class.getName());

    @Autowired
    public InterestService(InterestDAO interestDAO, MendeleyService mendeleyService) {
        this.interestDAO = interestDAO;
        this.mendeleyService = mendeleyService;
    }

    @Transactional
    public Interest saveOrUpdate(Interest interest) throws Exception {
        if (interest.getId() == 0 || find(interest.getId()) == null) {
            return interestDAO.add(interest);
        } else {
            return interestDAO.update(interest);
        }
    }

    @Transactional
    public void delete(Interest interest) throws Exception {
        interestDAO.delete(interest);
    }

    public Interest find(int interestId) {
        return interestDAO.find(interestId);
    }

    public List<Interest> findAll() {
        return interestDAO.findAll();
    }

    public Interest findByName(String name) {
        if (name != null) {
            Map<String, String> map = new HashMap<>();
            map.put("name", name);
            List<Interest> findBy = interestDAO.findBy(map);
            return findBy.size() > 0 ? findBy.get(0) : null;
        }
        return null;
    }

}
