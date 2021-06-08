package Group6.Distribution.service;

import Group6.Distribution.model.product;
import Group6.Distribution.repository.productRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
public class productService {
    @Autowired
    private productRepository productrepository;
    private static Logger logger = LoggerFactory.getLogger(productService.class);

    public List<product> findAll() {
        List<product> lp = productrepository.findAll();
        return lp;
    }

    public ResponseEntity<?> add(product product) {
        if(!productrepository.findByCode(product.getCode()).isEmpty()){
            return ResponseEntity.status(HttpStatus.CONFLICT).body("Product " + product.getCode() + " is existed");
        } else {
            productrepository.save(product);
            return ResponseEntity.status(HttpStatus.CREATED).body(product);
        }
    }

    public ResponseEntity<?> findOne(Integer id) {

        try {
            product product = productrepository.findById(id).get();
            return ResponseEntity.status(HttpStatus.OK).body(product);
        } catch(NoSuchElementException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Product ID:  " + id + " Not Found");
        }
    }



}
