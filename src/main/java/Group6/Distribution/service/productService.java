package Group6.Distribution.service;

import Group6.Distribution.model.product;
import Group6.Distribution.repository.productRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class productService {
    @Autowired
    private productRepository productrepository;
    private static Logger logger = LoggerFactory.getLogger(productService.class);

    public List<product> findAll() {
        List<product> lp = productrepository.findAll();
        return lp;
    }
}
