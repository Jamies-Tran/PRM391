package Group6.Distribution.controller;

import Group6.Distribution.model.loginForm;
import Group6.Distribution.model.order;
import Group6.Distribution.model.user;
import Group6.Distribution.service.userService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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

    @PostMapping("/login")
    public ResponseEntity login(@RequestBody loginForm lf) {

        return userservice.login(lf);
    }
}
