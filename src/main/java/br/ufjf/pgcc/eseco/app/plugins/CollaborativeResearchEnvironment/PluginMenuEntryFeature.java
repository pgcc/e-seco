package br.ufjf.pgcc.eseco.app.plugins.CollaborativeResearchEnvironment;

import br.ufjf.pgcc.eseco.app.model.plugins.PluginMenuEntryFeatureInterface;

public class PluginMenuEntryFeature implements PluginMenuEntryFeatureInterface {

    private String title;
    private String uri;

    @Override
    public String getTitle() {
        return this.title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUri() {
        return uri;
    }

    public void setUri(String uri) {
        this.uri = uri;
    }
}
