package Group6.Distribution.controller;

import Group6.Distribution.model.order;

import Group6.Distribution.model.ordpro;
import Group6.Distribution.service.orderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
}
