package vn.iotstar.dao.impl;

import java.util.Collections;
import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.dao.CategoryDao;
import vn.iotstar.model.Category;

/**
 * Lớp triển khai CategoryDaoImpl sử dụng công nghệ JPA (Hibernate)
 * Môn học: Lập Trình Web (HCMUTE - WEBPR330479)
 * Giảng viên: ThS. Nguyễn Hữu Trung
 * Sinh viên: Trương Gia Kiệt - MSSV: 24110032
 */
public class CategoryDaoImpl implements CategoryDao {

    @Override
    public void insert(Category category) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(category);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            e.printStackTrace();
        } finally {
            enma.close();
        }
    }

    @Override
    public void edit(Category category) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(category);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            e.printStackTrace();
        } finally {
            enma.close();
        }
    }

    @Override
    public void delete(int id) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            Category category = enma.find(Category.class, id);
            if (category != null) {
                enma.remove(category);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            e.printStackTrace();
        } finally {
            enma.close();
        }
    }

    @Override
    public Category get(int id) {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            return enma.find(Category.class, id);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            enma.close();
        }
    }

    @Override
    public Category get(String name) {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT c FROM Category c WHERE c.catename = :name";
            TypedQuery<Category> query = enma.createQuery(jpql, Category.class);
            query.setParameter("name", name);
            List<Category> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Category> getAll() {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT c FROM Category c ORDER BY c.cateid DESC";
            TypedQuery<Category> query = enma.createQuery(jpql, Category.class);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Category> search(String keyword) {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT c FROM Category c WHERE c.catename LIKE :keyword ORDER BY c.cateid DESC";
            TypedQuery<Category> query = enma.createQuery(jpql, Category.class);
            query.setParameter("keyword", "%" + keyword + "%");
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            enma.close();
        }
    }
}
