package br.ufjf.pgcc.eseco.domain.service.resource;

import br.ufjf.pgcc.eseco.domain.dao.resource.PluginDAO;
import br.ufjf.pgcc.eseco.domain.model.resource.Plugin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PluginService {

    private PluginDAO pluginDAO;

    @Autowired
    public PluginService(PluginDAO pluginDAO) {
        this.pluginDAO = pluginDAO;
    }

    public Plugin find(int pluginId) {
        return pluginDAO.find(pluginId);
    }

    public List<Plugin> findAll() {
        return pluginDAO.findAll();
    }

    @Transactional
    public Plugin add(Plugin plugin) throws Exception {
        return pluginDAO.add(plugin);
    }

    @Transactional
    public Plugin updateAgent(Plugin plugin) throws Exception {
        return pluginDAO.update(plugin);
    }
}
