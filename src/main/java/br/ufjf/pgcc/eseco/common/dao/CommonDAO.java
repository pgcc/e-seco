package br.ufjf.pgcc.eseco.common.dao;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public abstract class CommonDAO<T, PK extends Serializable> {

    protected Class<T> entityClass;

    @PersistenceContext
    protected EntityManager em;

    protected CommonDAO(Class<T> persistedClass) {
        this.entityClass = persistedClass;
    }

    /**
     * Add an entry in database.
     *
     * @param t object of some type (t) to insert in database
     *
     * @return return the object inserted
     */
    public T add(T t) {
        this.em.persist(t);
        return t;
    }

    public T update(T t) {
        return this.em.merge(t);
    }

    public void delete(T t) {
        t = this.em.merge(t);
        this.em.remove(t);
    }

    public T find(PK id) {
        return this.em.find(entityClass, id);
    }

    public List<T> findAll() {
        TypedQuery<T> results = this.getTypedQuery(new HashMap<String, String>());

        return results.getResultList();
    }

    public List<T> findBy(Map<String, String> fields) {
        TypedQuery<T> results = this.getTypedQuery(fields);

        return results.getResultList();
    }

    public T findOneBy(Map<String, String> fields) {
        TypedQuery<T> results = this.getTypedQuery(fields);

        try {
            return results.getSingleResult();
        } catch (NoResultException nre) {
            return null;
        }
    }

    private TypedQuery<T> getTypedQuery(Map<String, String> fields) {
        CriteriaBuilder criteriaBuilder = em.getCriteriaBuilder();
        CriteriaQuery<T> criteriaQuery = criteriaBuilder.createQuery(this.entityClass);
        Root<T> root = criteriaQuery.from(this.entityClass);

        if (!fields.isEmpty()) {
            List<Predicate> predicates = new ArrayList<Predicate>();
            for (Map.Entry<String, String> field : fields.entrySet()) {
                predicates.add(criteriaBuilder.equal(root.get(field.getKey()), field.getValue()));
            }

            criteriaQuery.where(predicates.toArray(new Predicate[]{}));
        }

        return em.createQuery(criteriaQuery);
    }
}