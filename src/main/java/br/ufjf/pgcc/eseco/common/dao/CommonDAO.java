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
    public T add(T t) throws Exception {
        this.em.persist(t);
        return t;
    }

    /**
     * Update an entry in database.
     *
     * @param t object of some type (t) to update in database
     *
     * @return return the object updated
     */
    public T update(T t) throws Exception {
        return this.em.merge(t);
    }

    /**
     * Delete an entry in database.
     *
     * @param t object of some type (t) to delete from database
     */
    public void delete(T t) throws Exception {
        t = this.em.merge(t);
        this.em.remove(t);
    }

    /**
     * Searches for an entry in database through its primary key.
     *
     * @param id The primary key to search an entry for
     *
     * @return Returns the found entry or NULL if none
     */
    public T find(int id) {
        return this.em.find(entityClass, id);
    }

    public List<T> findAll() {
        TypedQuery<T> results = this.getTypedQuery(new HashMap<String, String>());

        return results.getResultList();
    }

    /**
     * Searches the database for entries through their fields values.
     *
     * @param fields A list of fields and values to be used as search criteria
     *
     * @return The list of found entries
     */
    public List<T> findBy(Map<String, String> fields) {
        TypedQuery<T> results = this.getTypedQuery(fields);

        return results.getResultList();
    }

    /**
     * Search the database for a single entry through its fields values.
     *
     * @param fields A list of fields and values to be used as search criteria
     *
     * @return The found entry or NULL if none
     */
    public T findOneBy(Map<String, String> fields) {
        TypedQuery<T> results = this.getTypedQuery(fields);

        try {
            return results.getSingleResult();
        } catch (NoResultException nre) {
            return null;
        }
    }

    /**
     * Performs a query in database
     *
     * @param fields A list of fields and values to be used as criteria for query
     *
     * @return An list of found entries
     */
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
