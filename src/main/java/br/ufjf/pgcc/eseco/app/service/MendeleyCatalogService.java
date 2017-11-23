package br.ufjf.pgcc.eseco.app.service;

import br.ufjf.pgcc.eseco.app.model.MendeleyCatalog;
import com.google.gson.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

@Service
public class MendeleyCatalogService {

    @Autowired
    public MendeleyCatalogService() {
    }

    /**
     * Cria um Json Deserializer para o objeto Discipline
     *
     * @return Interest
     */
    public static JsonDeserializer<MendeleyCatalog> getDeserialiser() {
        return new JsonDeserializer() {
            @Override
            public MendeleyCatalog deserialize(JsonElement je, Type type, JsonDeserializationContext jdc) throws JsonParseException {
                final MendeleyCatalog mc = new MendeleyCatalog();
                JsonObject object = je.getAsJsonObject();

                if (object.get("title") != null) {
                    mc.setTitle(object.get("title").getAsString());
                }

                if (object.get("year") != null) {
                    mc.setYear(object.get("year").getAsString());
                }

                if (object.get("keywords") != null) {
                    List<String> keywords = new ArrayList<>();
                    for (JsonElement keyword : object.get("keywords").getAsJsonArray()) {
                        String name = keyword.toString();
                        name = name.replaceAll("\"", "");
                        name = name.replaceAll("\\.", "");
                        name = name.replaceAll("\\[", "");
                        name = name.replaceAll("]", "");

                        keywords.add(name);
                    }
                    mc.setKeywords(keywords);
                }

                return mc;
            }
        };
    }

}
