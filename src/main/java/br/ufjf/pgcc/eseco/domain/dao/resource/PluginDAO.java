package br.ufjf.pgcc.eseco.domain.dao.resource;

import br.ufjf.pgcc.eseco.domain.model.resource.Plugin;
import br.ufjf.pgcc.eseco.common.dao.CommonDAO;
import org.springframework.stereotype.Repository;

@Repository
public class PluginDAO extends CommonDAO<Plugin, Integer> {
    protected PluginDAO() {
        super(Plugin.class);
    }
}
