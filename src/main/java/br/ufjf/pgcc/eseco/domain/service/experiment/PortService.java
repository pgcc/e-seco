package br.ufjf.pgcc.eseco.domain.service.experiment;

import br.ufjf.pgcc.eseco.domain.dao.experiment.PortDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.Port;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class PortService {

    private final PortDAO portDAO;

    @Autowired
    public PortService(PortDAO portDAO) {
        this.portDAO = portDAO;
    }

    @Transactional
    public Port saveOrUpdate(Port port) throws Exception {
        if (port.getId() == 0 || find(port.getId()) == null) {
            return portDAO.add(port);
        } else {
            return portDAO.update(port);
        }
    }

    @Transactional
    public void delete(Port port) throws Exception {
        portDAO.delete(port);
    }

    public Port find(int portId) {
        return portDAO.find(portId);
    }

    public List<Port> findAll() {
        return portDAO.findAll();
    }

}
