package br.ufjf.pgcc.eseco.domain.model.analysis;

import java.util.ArrayList;

public class ServiceDependency {

    private String name;
    private int size;
    private ArrayList<ServiceDependency> children;


    /* CONSTRUCTORS */

    public ServiceDependency() {
        this.children = new ArrayList<ServiceDependency>();
    }


    /* GETTERS/SETTERS */

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public ArrayList<ServiceDependency> getChildren() {
        return children;
    }

    public void setChildren(ArrayList<ServiceDependency> children) {
        this.children = children;
    }


    /* OTHER METHODS */

    public void addChild(ServiceDependency child){
        this.children.add(child);
    }
}
