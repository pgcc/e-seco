package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.domain.model.experiment.Resource;
import br.ufjf.pgcc.eseco.domain.model.analysis.ServiceDependency;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.lang.reflect.Method;

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


        Resource resource = new Resource();
        resource.setId(id);
        resource.setName("WsUserList");
        resource.setClassName("br.ufjf.pgcc.eseco.webservice.WsUserList");


        Class cls = Class.forName(resource.getClassName());

        // returns public, protected, private and default method of that specific class only (it excludes inherited methods).
        Method methlist[] = cls.getDeclaredMethods();


        int MCount = cls.getDeclaredMethods().length;

        // Inheritence
        /*
        Class<?> class2 = cls.getSuperclass();
        Method[] methods2 = class2.getDeclaredMethods();
        MCount += class2.getDeclaredMethods().length;
        */

        System.out.println("total metodos na webservice: " + MCount);

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



