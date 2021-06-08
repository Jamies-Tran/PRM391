package Group6.Distribution.repository;

import Group6.Distribution.model.product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface productRepository extends JpaRepository<product, Integer> {
    @Query(value = "SELECT p FROM product p")
    List<product> findAllProduct();
}
