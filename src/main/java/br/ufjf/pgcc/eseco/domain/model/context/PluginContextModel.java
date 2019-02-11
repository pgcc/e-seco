package br.ufjf.pgcc.eseco.domain.model.context;

import java.util.Date;

public class PluginContextModel {

    // Basic Component Info
    private int id;
    private String name;
    private String type;
    private String author;
    private Date dateCreated;
    private Date dateUpdated;

    // Basic Plugin Info
    private String pluginInternalClass;


    /* CONSTRUCTORS */

    public PluginContextModel() {

    }


    /* GETTERS/SETTERS */

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    public Date getDateUpdated() {
        return dateUpdated;
    }

    public void setDateUpdated(Date dateUpdated) {
        this.dateUpdated = dateUpdated;
    }

    public String getPluginInternalClass() {
        return pluginInternalClass;
    }

    public void setPluginInternalClass(String pluginInternalClass) {
        this.pluginInternalClass = pluginInternalClass;
    }
}
