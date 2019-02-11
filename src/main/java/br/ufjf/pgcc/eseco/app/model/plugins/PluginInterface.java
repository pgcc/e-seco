package br.ufjf.pgcc.eseco.app.model.plugins;

import java.util.List;

public interface PluginInterface {

    String getName();

    List<PluginFeatures> getFeatures();

    PluginMenuEntryFeatureInterface getMenuEntryFeature();

    PluginBackgroundTaskFeatureInterface getBackgroundTaskFeature();

    PluginControllerFeatureInterface getControllerFeature();
}
