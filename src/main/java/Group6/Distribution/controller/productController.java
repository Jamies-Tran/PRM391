package Group6.Distribution.controller;

import Group6.Distribution.model.product;
import Group6.Distribution.service.productService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.json.MappingJacksonValue;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RequestMapping(path = "/distribution/product")
@RestController
public class productController {
    @Autowired
    private productService productservice;

    @GetMapping("/all")
    public List<product> findAllProduct() {
        return productservice.findAll();
    }

    @PostMapping("/create")
    public ResponseEntity<?> add(@Valid @RequestBody product product) {
        return productservice.add(product);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> one(@PathVariable Integer id) {
        return productservice.findOne(id);
    }

    @PutMapping("/update")
    public ResponseEntity<?> update(@Valid @RequestBody product product) {
        return productservice.update(product);

    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> delete(@PathVariable Integer id) {

        return productservice.deleteById(id);
    }
}
