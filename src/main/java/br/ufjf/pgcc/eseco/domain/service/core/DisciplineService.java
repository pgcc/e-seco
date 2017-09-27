package br.ufjf.pgcc.eseco.domain.service.core;

import br.ufjf.pgcc.eseco.domain.dao.core.DisciplineDAO;
import br.ufjf.pgcc.eseco.domain.model.core.Discipline;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class DisciplineService {

    private final DisciplineDAO disciplineDAO;

    @Autowired
    public DisciplineService(DisciplineDAO disciplineDAO) {
        this.disciplineDAO = disciplineDAO;
    }

    @Transactional
    public Discipline saveOrUpdate(Discipline discipline) throws Exception {
        if (discipline.getId() == 0 || find(discipline.getId()) == null) {
            return disciplineDAO.add(discipline);
        } else {
            return disciplineDAO.update(discipline);
        }
    }

    @Transactional
    public void delete(Discipline discipline) throws Exception {
        disciplineDAO.delete(discipline);
    }

    public Discipline find(int disciplineId) {
        return disciplineDAO.find(disciplineId);
    }

    public List<Discipline> findAll() {
        return disciplineDAO.findAll();
    }

}
