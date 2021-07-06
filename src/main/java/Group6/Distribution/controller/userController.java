package Group6.Distribution.controller;

import Group6.Distribution.model.order;
import Group6.Distribution.model.user;
import Group6.Distribution.service.userService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequestMapping(path = "/distribution/user")
@RestController
public class userController {
    @Autowired
    private userService userservice;

    @GetMapping("/{id}")
    public ResponseEntity<?> one(@PathVariable Integer id) {

        return userservice.findOne(id);
    }

    @GetMapping("/all")
    public List<user> findAllProduct() {

        return userservice.findAll();
    }
}
