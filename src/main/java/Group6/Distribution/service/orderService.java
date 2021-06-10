package Group6.Distribution.service;

import Group6.Distribution.model.order;


import Group6.Distribution.model.ordpro;
import Group6.Distribution.repository.orderRepository;

import Group6.Distribution.repository.ordproRepository;
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
public class orderService {

    @Autowired
    private orderRepository OrderRepository;
    @Autowired
    private ordproRepository OrdProRepository;
    private static Logger logger = LoggerFactory.getLogger(orderService.class);


    public ResponseEntity<?> findOne(Integer id) {
        try {
            Optional<order> Order = OrderRepository.findById(id);
            return ResponseEntity.status(HttpStatus.OK).body(Order);
        } catch(NoSuchElementException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Order ID:  " + id + " Not Found");
        }
    }

    public List<order> findAll() {
        List<order> lo = OrderRepository.findAllOrder();
        return lo;
    }

    public List<ordpro> viewOrder(int id) {

        List<ordpro> lop = OrdProRepository.ViewProductInOrder(id);

        return lop;
    }

}
