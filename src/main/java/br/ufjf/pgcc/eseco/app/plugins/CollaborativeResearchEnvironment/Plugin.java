package br.ufjf.pgcc.eseco.app.plugins.CollaborativeResearchEnvironment;

import br.ufjf.pgcc.eseco.app.model.plugins.*;

import java.util.ArrayList;
import java.util.List;

public class Plugin implements PluginInterface {

    private PluginMenuEntryFeature pluginMenuEntryFeature;

    @Override
    public String getName() {
        return "Collaborative Research Environment";
    }

    @Override
    public List<PluginFeatures> getFeatures() {
        List<PluginFeatures> pluginFeaturesList = new ArrayList<>();
        pluginFeaturesList.add(PluginFeatures.MENU_ENTRY);
        pluginFeaturesList.add(PluginFeatures.CONTROLLER);

        return pluginFeaturesList;
    }

    @Override
    public PluginMenuEntryFeatureInterface getMenuEntryFeature() {
        if (pluginMenuEntryFeature == null) {
            PluginMenuEntryFeature newPluginMenuEntryFeature = new PluginMenuEntryFeature();
            newPluginMenuEntryFeature.setTitle("Collaborative Research Environment");
            newPluginMenuEntryFeature.setUri("/cre");

            pluginMenuEntryFeature = newPluginMenuEntryFeature;
        }

        return pluginMenuEntryFeature;
    }

    @Override
    public PluginBackgroundTaskFeatureInterface getBackgroundTaskFeature() {
        return null;
    }

    @Override
    public PluginControllerFeatureInterface getControllerFeature() {
        return null;
    }
}
