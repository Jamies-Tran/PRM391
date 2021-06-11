package Group6.Distribution.service;

import Group6.Distribution.model.product;
import Group6.Distribution.repository.productRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.json.MappingJacksonValue;
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

    public  ResponseEntity<?> update(product pt, Integer id){
        try{
            product p1 = productrepository.findById(id).get();
            p1.setId(id);
            p1.setName(pt.getName());
            p1.setCategory(pt.getCategory());
            p1.setCode(pt.getCode());
            p1.setPrice(pt.getPrice());
            p1.setStock(pt.getStock());
            p1.setImage(pt.getImage());
            productrepository.save(p1);

            return ResponseEntity.status(HttpStatus.OK).body(p1);
        }catch(NoSuchElementException e){
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body("Product ID:  " + pt.getId() + " Not Found");
        }
    }

    public ResponseEntity<String> deleteById(Integer id) {
        try {
            product p1 = productrepository.findById(id).get();
            productrepository.delete(p1);
            return ResponseEntity.status(HttpStatus.OK).body("Product ID: " + id + " Deleted");
        } catch (NoSuchElementException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Product ID: " + id + " Not found");
        }
    }
}
