package br.ufjf.pgcc.eseco.domain.service.experiment;

import br.ufjf.pgcc.eseco.domain.dao.experiment.WfmsDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.Wfms;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class WfmsService {

    private final WfmsDAO wfmsDAO;

    @Autowired
    public WfmsService(WfmsDAO wfmsDAO) {
        this.wfmsDAO = wfmsDAO;
    }

    @Transactional
    public Wfms saveOrUpdate(Wfms wfms) throws Exception {
        if (wfms.getId() == 0 || find(wfms.getId()) == null) {
            return wfmsDAO.add(wfms);
        } else {
            return wfmsDAO.update(wfms);
        }
    }

    @Transactional
    public void delete(Wfms wfms) throws Exception {
        wfmsDAO.delete(wfms);
    }

    public Wfms find(int wfmsId) {
        return wfmsDAO.find(wfmsId);
    }

    public List<Wfms> findAll() {
        return wfmsDAO.findAll();
    }

}
