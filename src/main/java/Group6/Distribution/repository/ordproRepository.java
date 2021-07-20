package Group6.Distribution.repository;

import Group6.Distribution.model.ordpro;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ordproRepository extends JpaRepository<ordpro, Integer> {

    @Query(value = "SELECT ordpro.*\n" +
            "FROM dbapp.order AS ord JOIN ordpro ON ordpro.order_id = ord.id\n" +
            "JOIN product ON ordpro.product_id = product.id\n" +
            "WHERE ord.id = :id", nativeQuery = true)
    List<ordpro> ViewProductInOrder(int id);

    @Modifying
    @Query(value = "Delete \n" +
            "From ordpro \n" +
            "WHERE order_id = :orderID", nativeQuery = true)
    void deleteByOrderID (int orderID);
}
