package br.ufjf.pgcc.eseco.domain.service.context;

import br.ufjf.pgcc.eseco.domain.model.context.PluginContextModel;
import br.ufjf.pgcc.eseco.domain.model.resource.*;
import org.springframework.stereotype.Service;

@Service
public class PluginContextModelService {


    public PluginContextModelService() {

    }


    public PluginContextModel createModelInfo(Component component) throws Exception {
        // Get the plugin of this resource
        Plugin plugin = component.getPlugin();

        if (null == plugin) {
            return null;
        }

        PluginContextModel pcm = new PluginContextModel();

        // Get Basic info from Component
        pcm.setId(component.getId());
        pcm.setName(component.getName());
        pcm.setType(component.getType().getName());
        pcm.setAuthor(component.getAuthor().getAgent().getName());
        pcm.setDateCreated(component.getDateCreated());
        pcm.setDateUpdated(component.getDateUpdated());

        // Get Basic info from WorkflowService
        pcm.setPluginInternalClass(plugin.getInternalClass());

        return pcm;
    }

}