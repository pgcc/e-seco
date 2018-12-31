package br.ufjf.pgcc.eseco.domain.service.core;

import br.ufjf.pgcc.eseco.domain.dao.core.CountryDAO;
import br.ufjf.pgcc.eseco.domain.model.core.Country;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

@Service
public class CountryService {

    private final CountryDAO countryDAO;

    @Autowired
    public CountryService(CountryDAO countryDao) {
        this.countryDAO = countryDao;
    }

    @Transactional
    public Country saveOrUpdate(Country country) throws Exception {
        if (country.getId() == 0 || find(country.getId()) == null) {
            return countryDAO.add(country);
        } else {
            return countryDAO.update(country);
        }
    }

    @Transactional
    public Country registerNewCountry(Country country) throws Exception {

        country = countryDAO.add(country);

        return country;
    }

    @Transactional
    public void delete(Country country) throws Exception {
        countryDAO.delete(country);
    }

    public Country find(int countryId) {
        return countryDAO.find(countryId);
    }

    public List<Country> findAll() {
        return countryDAO.findAll();
    }

    public Country findByNameOrCode(String name) {
        if (name != null) {
            Map<String, String> map = new HashMap<>();
            map.put("name", name);

            List<Country> findBy = countryDAO.findBy(map);
            if (findBy.size() <= 0) {
                map = new HashMap<>();
                map.put("code", name);
                findBy = countryDAO.findBy(map);
            }
            return findBy.size() > 0 ? findBy.get(0) : null;
        }
        return null;
    }

}
