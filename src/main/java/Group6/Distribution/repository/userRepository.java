package Group6.Distribution.repository;

import Group6.Distribution.model.order;
import Group6.Distribution.model.user;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface userRepository extends JpaRepository<user, Integer> {

    @Query(value = "SELECT u FROM user u")
    List<user> findAllUser();

    @Query(value = "select dbapp.user.*\n" + "from dbapp.user\n" + "WHERE username = :username AND password = :password"
            , nativeQuery = true)
    Optional<user> findUser(String username, String password);
}
