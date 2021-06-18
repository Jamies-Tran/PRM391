package Group6.Distribution.controller;

import Group6.Distribution.model.customOrd;
import Group6.Distribution.model.order;

import Group6.Distribution.model.ordpro;
import Group6.Distribution.model.product;
import Group6.Distribution.service.orderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RequestMapping(path = "/distribution/order")
@RestController
public class orderController {
    @Autowired
    private orderService orderService;

    @GetMapping("/{id}")
    public ResponseEntity<?> one(@PathVariable Integer id) {

        return orderService.findOne(id);
    }

    @GetMapping("/all")
    public List<order> findAllProduct() {

        return orderService.findAll();
    }

    @GetMapping("/detail/{id}")
    public List<ordpro> detailOrder(@PathVariable int id) {

        return orderService.viewOrder(id);
    }

    @PostMapping("/create")
    public ResponseEntity<order> add(@Valid @RequestBody customOrd cOrd) {

        return orderService.createOrder(cOrd);
    }

}
