package Group6.Distribution.service;

import Group6.Distribution.model.user;
import Group6.Distribution.repository.userRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

@Service
public class userService {

    @Autowired
    private userRepository UserRepository;

    private static Logger logger = LoggerFactory.getLogger(userService.class);

    public ResponseEntity<?> findOne(Integer id) {
        try {
            Optional<user> User = UserRepository.findById(id);
            return ResponseEntity.status(HttpStatus.OK).body(User);
        } catch (NoSuchElementException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User ID:  " + id + " Not Found");
        }
    }

    public List<user> findAll() {
        List<user> lu = UserRepository.findAllUser();
        return lu;
    }
}
