package br.ufjf.pgcc.eseco.app.controller;

import br.ufjf.pgcc.eseco.app.model.ApiRestResult;
import br.ufjf.pgcc.eseco.domain.model.resource.WorkflowService;
import br.ufjf.pgcc.eseco.domain.service.resource.WorkflowServiceService;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.ReflectionUtils;
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

        String url = "http://nenc.ufjf.br:8080/eseco/api/" + area + "/" + serviceName;
        WorkflowService workflowService = workflowServiceService.findOneByUrl(url);

        if (workflowService == null) {
            apiRestResult.setError("Service not found");
            return gson.toJson(apiRestResult);
        }

        try {
            Class internalClass = Class.forName(workflowService.getInternalClass());

            String requestedMethod = request.getParameter("r");
            String[] requestedMethodParameters = new String[]{};
            if(request.getParameterValues("p") != null){
                requestedMethodParameters = request.getParameterValues("p");
            }

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
                        Parameter[] parameters = m.getParameters();
                        List<String> parameterNames = new ArrayList<>();
                        List<Class<?>> parameterTypes = new ArrayList<>();

                        for (Parameter parameter : parameters) {
                            parameterNames.add(parameter.getName());
                            parameterTypes.add(parameter.getType());
                        }

                        Constructor ctor = internalClass.getConstructor();
                        Object object = ctor.newInstance();

                        if(requestedMethodParameters.length != parameterNames.size()){
                            throw new Exception("Parameter count diverge. Required ["+parameterNames.size()+"] Passed ["+requestedMethodParameters.length+"]");
                        }

                        String methodResult = "";
                        if (parameterNames.size() == 1) {
                            if (parameterTypes.get(0).toString().equals("int")) {
                                methodResult = (String) m.invoke(object, Integer.parseInt(requestedMethodParameters[0]));
                            } else if (parameterTypes.get(0).equals(String.class)) {
                                methodResult = (String) m.invoke(object, requestedMethodParameters[0]);
                            }

                        } else if (parameterNames.size() == 2) {
                            methodResult = (String) m.invoke(object,
                                    requestedMethodParameters[0],
                                    requestedMethodParameters[1]
                            );
                        }

                        JsonParser parser = new JsonParser();
                        JsonObject o = parser.parse(methodResult).getAsJsonObject();

                        apiRestResult.setJsonData(o);
                    }
                }
            }


            return gson.toJson(apiRestResult);

        } catch (Exception e) {
            apiRestResult.setError(e.getMessage());
            return gson.toJson(apiRestResult);
        }
    }


}