package br.ufjf.pgcc.eseco.domain.service.core;

import br.ufjf.pgcc.eseco.domain.dao.core.CityDAO;
import br.ufjf.pgcc.eseco.domain.model.core.City;
import br.ufjf.pgcc.eseco.domain.model.core.State;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class CityService {

    private final CityDAO cityDAO;

    @Autowired
    public CityService(CityDAO cityDao) {
        this.cityDAO = cityDao;
    }

    @Transactional
    public City saveOrUpdate(City city) throws Exception {
        if (city.getId() == 0 || find(city.getId()) == null) {
            return cityDAO.add(city);
        } else {
            return cityDAO.update(city);
        }
    }

    @Transactional
    public City registerNewCity(City city) throws Exception {

        city = cityDAO.add(city);

        return city;
    }

    @Transactional
    public void delete(City city) throws Exception {
        cityDAO.delete(city);
    }

    public City find(int cityId) {
        return cityDAO.find(cityId);
    }

    public List<City> findAll() {
        return cityDAO.findAll();
    }

    public City findByNameAndState(String name, State state) {
        if (name != null) {
            Map<String, String> map = new HashMap<>();
            map.put("name", name);
            List<City> findBy = cityDAO.findBy(map);
            if (findBy.size() > 0) {
                for (City city : findBy) {
                    if (city.getState().getId() == state.getId()) {
                        return city;
                    }
                }
            }
        }
        return null;

    }
}
