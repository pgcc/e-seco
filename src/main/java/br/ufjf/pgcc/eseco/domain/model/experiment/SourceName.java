package br.ufjf.pgcc.eseco.domain.model.experiment;

import java.util.ArrayList;
import java.util.List;

public enum SourceName {
    //copiar EntityKind

    DARKSKY("DarkSky"),
    UFJF("UFJF"),
    OPENWEATHER("OpenWeather");

    public final String name;

    private SourceName(String value) {

        name = value;
    }

    public String getName() {

        return name;
    }

    public static List<SourceName> getList() {
        List<SourceName> list = new ArrayList<>();
        list.add(DARKSKY);
        list.add(UFJF);
        list.add(OPENWEATHER);
        return list;
    }
}
