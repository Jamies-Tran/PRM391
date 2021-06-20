package Group6.Distribution.service;

import Group6.Distribution.model.customOrd;
import Group6.Distribution.model.order;


import Group6.Distribution.model.ordpro;
import Group6.Distribution.repository.orderRepository;

import java.sql.Timestamp;

import Group6.Distribution.repository.ordproRepository;
import Group6.Distribution.repository.productRepository;
import org.aspectj.weaver.ast.Or;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

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

    public ResponseEntity<order> createOrder(customOrd cOrd) {
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        order Order = new order();
        Order.setOrderCus(cOrd.getOrderCus());
        Order.setOrderDis(cOrd.getOrderDis());
        Order.setOrderSta(cOrd.getOrderSta());
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
        OrderRepository.save(Order);
        OrdProRepository.saveAll(products);
        return ResponseEntity.status(HttpStatus.CREATED).body(Order);
    }

}
