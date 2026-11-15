package vn.iotstar.dao.impl;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.dao.UserDao;
import vn.iotstar.model.User;

/**
 * Lớp triển khai UserDaoImpl sử dụng công nghệ JPA (Hibernate)
 * 
 * Dự án: Bài Tập Lập Trình Web (HCMUTE - WEBPR330479)
 * Sinh viên: Trương Gia Kiệt - MSSV: 24110032
 */
public class UserDaoImpl implements UserDao {

    @Override
    public User get(String username) {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE u.userName = :username";
            TypedQuery<User> query = enma.createQuery(jpql, User.class);
            query.setParameter("username", username);
            List<User> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            enma.close();
        }
    }

    @Override
    public void insert(User user) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(user);
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
    public boolean checkExistEmail(String email) {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT COUNT(u) FROM User u WHERE u.email = :email";
            TypedQuery<Long> query = enma.createQuery(jpql, Long.class);
            query.setParameter("email", email);
            Long count = query.getSingleResult();
            return count != null && count > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            enma.close();
        }
    }

    @Override
    public boolean checkExistUsername(String username) {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT COUNT(u) FROM User u WHERE u.userName = :username";
            TypedQuery<Long> query = enma.createQuery(jpql, Long.class);
            query.setParameter("username", username);
            Long count = query.getSingleResult();
            return count != null && count > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            enma.close();
        }
    }

    @Override
    public boolean checkExistPhone(String phone) {
        EntityManager enma = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT COUNT(u) FROM User u WHERE u.phone = :phone";
            TypedQuery<Long> query = enma.createQuery(jpql, Long.class);
            query.setParameter("phone", phone);
            Long count = query.getSingleResult();
            return count != null && count > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            enma.close();
        }
    }
}
