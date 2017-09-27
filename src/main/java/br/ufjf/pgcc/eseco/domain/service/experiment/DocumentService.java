package br.ufjf.pgcc.eseco.domain.service.experiment;

import br.ufjf.pgcc.eseco.domain.dao.experiment.DocumentDAO;
import br.ufjf.pgcc.eseco.domain.model.experiment.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class DocumentService {

    private final DocumentDAO documentDAO;

    @Autowired
    public DocumentService(DocumentDAO documentDAO) {
        this.documentDAO = documentDAO;
    }

    @Transactional
    public Document saveOrUpdate(Document document) throws Exception {
        if (document.getId() == 0 || find(document.getId()) == null) {
            return documentDAO.add(document);
        } else {
            return documentDAO.update(document);
        }
    }

    @Transactional
    public void delete(Document document) throws Exception {
        documentDAO.delete(document);
    }

    public Document find(int documentId) {
        return documentDAO.find(documentId);
    }

    public List<Document> findAll() {
        return documentDAO.findAll();
    }

}
