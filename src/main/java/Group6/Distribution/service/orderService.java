package Group6.Distribution.service;

import Group6.Distribution.model.*;


import Group6.Distribution.repository.*;

import java.sql.Timestamp;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class orderService {

    @Autowired
    private orderRepository OrderRepository;
    @Autowired
    private ordproRepository OrdProRepository;
    @Autowired
    private productRepository ProductRepository;
    @Autowired
    private userRepository UserRepository;


    private static final SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private static Logger logger = LoggerFactory.getLogger(orderService.class);


    public ResponseEntity<?> findOne(Integer id) {
        try {
            Optional<order> Order = OrderRepository.findById(id);
            return ResponseEntity.status(HttpStatus.OK).body(Order);
        } catch (NoSuchElementException e) {
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

    public ResponseEntity<?> createOrder(customOrd cOrd, Integer id) {
        try {
            Timestamp timestamp = new Timestamp(System.currentTimeMillis());
            order Order = new order();
            user Customer = UserRepository.findById(id).get();
            Order.setOrderCus(Customer.getUsername());

            Order.setOrderSta(0);
            Order.setInvoiceDate(timestamp);
            Order.setTotalOrderPrice(0);
            Set<ordpro> products = new HashSet<ordpro>();

            List<Integer> listQuan = cOrd.getProductInOrder().stream().map(customOrd.listProduct::getQuantity).collect(Collectors.toList());
            var ref = new Object() {
                int i = 0;
            };
            ProductRepository.findAllById(cOrd.getProductInOrder().stream().map(customOrd.listProduct::getProID).collect(Collectors.toList()))
                    .forEach(prod -> {
                        ordpro ordpro = new ordpro();
                        ordpro.setProduct(prod);
                        ordpro.setOrder(Order);
                        ordpro.setQuantity(listQuan.get(ref.i));
                        ordpro.setTotalPrice(prod.getPrice() * listQuan.get(ref.i));
                        ref.i++;
                        products.add(ordpro);
                        Order.setTotalOrderPrice(Order.getTotalOrderPrice() + ordpro.getTotalPrice());

                    });
            Order.setProductInOrder(products);
            Order.setUser(Customer);
            OrderRepository.save(Order);
            OrdProRepository.saveAll(products);

            return ResponseEntity.status(HttpStatus.CREATED).body(Order);
        }  catch (NoSuchElementException e) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Customer ID:  " + id + " Not Found");
    }

    }

    public ResponseEntity<?> updateStatus(Integer id, order ord) {
        try {
            order Order = OrderRepository.findById(id).get();
            Order.setOrderSta(ord.getOrderSta());
            OrderRepository.save(Order);
            return ResponseEntity.status(HttpStatus.OK).body(Order);
        } catch (NoSuchElementException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Order ID:  " + id + " Not Found");
        }
    }

    public ResponseEntity<String> deleteById(Integer id) {
        try {
            order p1 = OrderRepository.findById(id).get();
            if(p1.getOrderSta() != 0 ) {
                return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE).body("Order ID: " + id + " is in wrong status");
            }
            else {
                OrderRepository.delete(p1);
                return ResponseEntity.status(HttpStatus.OK).body("Order ID: " + id + " Deleted");
            }
        } catch (NoSuchElementException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Order ID: " + id + " Not found");
        }
    }
    @Transactional
    public ResponseEntity<?> updateOrder(customOrd cOrd, Integer userID, Integer orderID) {
        try {
            order Order = OrderRepository.findById(orderID).get();
            if(Order.getOrderSta() != 0 ) {
                return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE).body("Order ID: " + orderID + " is in wrong status");
            }
            else {
                OrdProRepository.deleteByOrderID(orderID);
                Timestamp timestamp = new Timestamp(System.currentTimeMillis());
                user Customer = UserRepository.findById(userID).get();
                Order.setId(orderID);
                Order.setOrderCus(Customer.getUsername());
                Order.setOrderSta(0);
                Order.setInvoiceDate(timestamp);
                Order.setTotalOrderPrice(0);
                Set<ordpro> products = new HashSet<ordpro>();

                List<Integer> listQuan = cOrd.getProductInOrder().stream().map(customOrd.listProduct::getQuantity).collect(Collectors.toList());
                var ref = new Object() {
                    int i = 0;
                };
                ProductRepository.findAllById(cOrd.getProductInOrder().stream().map(customOrd.listProduct::getProID).collect(Collectors.toList()))
                        .forEach(prod -> {
                            ordpro ordpro = new ordpro();
                            ordpro.setProduct(prod);
                            ordpro.setOrder(Order);
                            ordpro.setQuantity(listQuan.get(ref.i));
                            ordpro.setTotalPrice(prod.getPrice() * listQuan.get(ref.i));
                            ref.i++;
                            products.add(ordpro);
                            Order.setTotalOrderPrice(Order.getTotalOrderPrice() + ordpro.getTotalPrice());

                        });

                Order.setProductInOrder(products);
                Order.setUser(Customer);
                OrderRepository.save(Order);
                OrdProRepository.saveAll(products);
                return ResponseEntity.status(HttpStatus.OK).body(Order);
            }

        }catch (NoSuchElementException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("UserID or OrderID: " + " Not found");
        }

    }
}
