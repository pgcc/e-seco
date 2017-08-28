package br.ufjf.pgcc.eseco.domain.model.misc;

public class Notification {

    private String text;
    private String link;
    private String icon;
    private boolean important;


    /* GETTERS/SETTERS */

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public boolean isImportant() {
        return important;
    }

    public void setImportant(boolean important) {
        this.important = important;
    }
}
