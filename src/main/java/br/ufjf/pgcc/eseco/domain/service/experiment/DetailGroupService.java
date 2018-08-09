package br.ufjf.pgcc.eseco.domain.service.experiment;

import br.ufjf.pgcc.eseco.domain.dao.experiment.DetailGroupDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.DetailGroup;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class DetailGroupService {

    private final DetailGroupDAO detailGroupDAO;

    @Autowired
    public DetailGroupService(DetailGroupDAO detailGroupDAO) {
        this.detailGroupDAO = detailGroupDAO;
    }

    @Transactional
    public DetailGroup saveOrUpdate(DetailGroup detailGroup) throws Exception {
        if (detailGroup.getId() == 0 || find(detailGroup.getId()) == null) {
            return detailGroupDAO.add(detailGroup);
        } else {
            return detailGroupDAO.update(detailGroup);
        }
    }

    @Transactional
    public void delete(DetailGroup detailGroup) throws Exception {
        detailGroupDAO.delete(detailGroup);
    }

    public DetailGroup find(int detailGroupId) {
        return detailGroupDAO.find(detailGroupId);
    }

    public List<DetailGroup> findAll() {
        return detailGroupDAO.findAll();
    }

}
