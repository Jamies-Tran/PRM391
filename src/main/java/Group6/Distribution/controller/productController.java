package Group6.Distribution.controller;

import Group6.Distribution.model.product;
import Group6.Distribution.service.productService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequestMapping(path = "/Distribution/Group")
@RestController
public class productController {
    @Autowired
    private productService productservice;

    @GetMapping("/All")
    public List<product> findAllProduct() {
        return productservice.findAll();
    }
}
