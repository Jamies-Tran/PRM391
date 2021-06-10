package Group6.Distribution.repository;


import Group6.Distribution.model.order;

import Group6.Distribution.model.ordpro;
import Group6.Distribution.model.product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface orderRepository extends JpaRepository<order, Integer> {
    @Query(value = "SELECT o FROM order o")
    List<order> findAllOrder();


}
