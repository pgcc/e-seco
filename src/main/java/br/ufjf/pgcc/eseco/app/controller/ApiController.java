package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.model.ApiRestResult;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowService;
import br.ufjf.pgcc.eseco.domain.service.resource.WorkflowServiceService;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.*;
import java.util.ArrayList;
import java.util.List;

@Controller
public class ApiController {

    private WorkflowServiceService workflowServiceService;

    @Autowired
    public ApiController(WorkflowServiceService workflowServiceService) {
        this.workflowServiceService = workflowServiceService;
    }


    @RequestMapping(value = "/api/{area}/{serviceName}", method = RequestMethod.GET, produces = "application/json")
    public @ResponseBody
    String runService(@PathVariable(value = "area") String area,
                      @PathVariable(value = "serviceName") String serviceName,
                      HttpServletRequest request) {

        ApiRestResult apiRestResult = new ApiRestResult();
        Gson gson = new Gson();

        String url = "https://nenc.ufjf.br/eseco/api/" + area + "/" + serviceName;
        WorkflowService workflowService = workflowServiceService.findOneByUrl(url);

        if (workflowService == null) {
            apiRestResult.setError("Service not found");
            return gson.toJson(apiRestResult);
        }

        try {
            Class internalClass = Class.forName(workflowService.getInternalClass());

            String requestedMethod = request.getParameter("r");
            String[] requestedMethodParameters = request.getParameterValues("p");

            if (requestedMethod == null) {
                ArrayList<String> linksList = new ArrayList<>();
                for (Method m : internalClass.getDeclaredMethods()) {
                    if (Modifier.isPublic(m.getModifiers())) {
                        linksList.add(url + "?r=" + m.getName());
                    }
                }
                apiRestResult.set_links(linksList);

            } else {
                for (Method m : internalClass.getDeclaredMethods()) {
                    if (m.getName().equals(requestedMethod)) {
                        System.out.println("achou metodo" + m.getName());

                        Parameter[] parameters = m.getParameters();
                        List<String> parameterNames = new ArrayList<>();
                        List<Class<?>> parameterTypes = new ArrayList<>();

                        for (Parameter parameter : parameters) {
                            parameterNames.add(parameter.getName());
                            parameterTypes.add(parameter.getType());
                        }

                        System.out.println(parameterNames);
                        System.out.println(parameterNames.get(0));
                        System.out.println(parameterTypes);
                        System.out.println(parameterTypes.get(0));
                        System.out.println(requestedMethodParameters.length);
                        for (String s : requestedMethodParameters) {
                            System.out.println("parametro: " + s);
                        }
                        System.out.println(internalClass);

                        Constructor ctor = internalClass.getConstructor();
                        Object object = ctor.newInstance();

                        System.out.println(object);

                        System.out.println(m.getReturnType().toString());
                        if(m.getReturnType().toString().contains("String")){
                            System.out.println("retorno do metodo eh string");
                        }

                        String methodResult = "";
                        if (parameterNames.size() == 1) {
                            if (parameterTypes.get(0).toString().equals("int")) {
                                methodResult = (String) m.invoke(object, Integer.parseInt(requestedMethodParameters[0]));
                            } else if (parameterTypes.get(0).toString().equals("string")) {
                                methodResult = (String) m.invoke(object, requestedMethodParameters[0]);
                            }

                        } else if (parameterNames.size() == 2) {
                            methodResult = (String) m.invoke(object,
                                    requestedMethodParameters[0],
                                    requestedMethodParameters[1]
                            );
                        }


                     //   String methodResultJson = gson.fromJson(methodResult, String.class);
                    //    System.out.println(methodResultJson);

                        JsonParser parser = new JsonParser();
                        JsonObject o = parser.parse(methodResult).getAsJsonObject();

                        System.out.println(o.toString());
                        System.out.println(methodResult);
                        //apiRestResult.setData(o.toString());
                        apiRestResult.setJsonData(o);
                        //apiRestResult.setData(methodResult);
                    }
                }
            }


            return gson.toJson(apiRestResult);

        } catch (Exception e) {
            System.out.println(e.getMessage());
            apiRestResult.setError(e.getMessage());
            return gson.toJson(apiRestResult);
        }
    }


}