package br.ufjf.pgcc.eseco.domain.service.core;

import br.ufjf.pgcc.eseco.domain.dao.core.CountryDAO;
import br.ufjf.pgcc.eseco.domain.model.core.Country;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

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

    @Transactional
    public Country find(int countryId) {
        return countryDAO.find(countryId);
    }

    @Transactional(readOnly = true)
    public List<Country> findAll() {
        return countryDAO.findAll();
    }

    public List<Country> findByName(String name) {
        if (name != null) {
            Map<String, String> map = new HashMap<>();
            map.put("name", name);

            return countryDAO.findBy(map);
        } else {
            return null;
        }
    }
}
