package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.domain.model.experiment.Resource;
import br.ufjf.pgcc.eseco.domain.model.analysis.ServiceDependency;
import com.google.gson.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Method;
import java.net.HttpURLConnection;
import java.net.URL;

@Controller
public class ServicesController {

    @RequestMapping(value = "/services")
    public String overview() {
        return "services/overview";
    }

    @RequestMapping(value = "/services/explore")
    public String explore() {
        return "services/explore";
    }

    @RequestMapping(value = "/services/explore/single/{id}")
    public String exploreSingle(Model model, @PathVariable(value = "id") int id) throws ClassNotFoundException {


        String sURL = "http://freegeoip.net/json/"; //just a string
        String sURL2 = "https://www.biocatalogue.org/search.json?q=gene&scope=services"; //just a string

        // Connect to the URL using java's native library
        URL url = null;
        try {
            url = new URL(sURL2);
            HttpURLConnection request = null;
            request = (HttpURLConnection) url.openConnection();
            request.connect();

            // Convert to a JSON object to print data
            JsonParser jp = new JsonParser(); //from gson
            JsonElement root = jp.parse(new InputStreamReader((InputStream) request.getContent())); //Convert the input stream to a json element
            JsonObject rootobj = root.getAsJsonObject(); //May be an array, may be an object.
            //String city = rootobj.get("city").getAsString(); //just grab the zipcode
          // String search = rootobj.get("search").getAsString(); //just grab the zipcode
            //String search_query = rootobj.get("search_query").getAsString(); //just grab the zipcode
            String sq = rootobj.getAsJsonObject("search").get("search_query").getAsString();

            //System.out.println("search: " + search);
            //System.out.println("search_query: " + search_query);
            System.out.println("sq: " + sq);

        } catch (IOException e) {
            System.out.println("erro");
            e.printStackTrace();
        }


        Resource resource = new Resource();
        resource.setId(id);
        resource.setName("WsUserList");
        resource.setClassName("br.ufjf.pgcc.eseco.webservice.WsUserList");

        /*
        Class cls = Class.forName(resource.getClassName());

        // returns public, protected, private and default method of that specific class only (it excludes inherited methods).
        Method methlist[] = cls.getDeclaredMethods();


        int MCount = cls.getDeclaredMethods().length;

        // Inheritence
        Class<?> class2 = cls.getSuperclass();
        Method[] methods2 = class2.getDeclaredMethods();
        MCount += class2.getDeclaredMethods().length;


        System.out.println("total metodos na webservice: " + MCount);
        */

        // -----------------------------------------------------------------------------------------------------------
        Class clsAgent = Class.forName("br.ufjf.pgcc.eseco.domain.model.core.Agent");
        System.out.println("total metodos na Agent: " + clsAgent.getDeclaredMethods().length);


        /*
        Gson gson = new Gson();
        int[][] data = {{1, 2, 3}, {3, 4, 5}, {4, 5, 6}};
        String json = gson.toJson(data);
        System.out.println("Data = " + json);
        */

        model.addAttribute("service", resource);
        return "services/explore-single";
    }

    @RequestMapping(value = "/returnjson", method = RequestMethod.GET)
    @ResponseBody
    public String returnJson() {

        ServiceDependency sd = new ServiceDependency();
        sd.setName("WsUserList");

        ServiceDependency sd2 = new ServiceDependency();
        sd2.setName("br.ufjf.pgcc.eseco.dao.AgentDAO");

        ServiceDependency sd3 = new ServiceDependency();
        sd3.setName("br.ufjf.pgcc.eseco.model.Agent");
        sd3.setSize(5);

        sd2.addChild(sd3);
        sd.addChild(sd2);

        Gson gson = new GsonBuilder().create();

        return gson.toJson(sd);
    }
}



