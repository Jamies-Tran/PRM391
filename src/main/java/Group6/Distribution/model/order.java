package Group6.Distribution.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import javax.persistence.*;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "`order`")
public class order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "orderDis")
    private String orderDis;

    @Column(name = "orderCus")
    private String orderCus;

    @Column(name = "orderSta")
    private int orderSta;

    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @Column(name = "invoiceDate")
    private Timestamp invoiceDate;

    @Column(name = "totalOrderPrice")
    private int totalOrderPrice;

    //@JsonIgnore
    @OneToMany(mappedBy = "order")
    private Set<ordpro> productInOrder = new HashSet<>();

    public order() {}

    public order(Integer id, String orderDis, String orderCus, int orderSta, Timestamp invoiceDate, int totalOrderPrice, Set<ordpro> productInOrder) {
        this.id = id;
        this.orderDis = orderDis;
        this.orderCus = orderCus;
        this.orderSta = orderSta;
        this.invoiceDate = invoiceDate;
        this.totalOrderPrice = totalOrderPrice;
        this.productInOrder = productInOrder;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getOrderDis() {
        return orderDis;
    }

    public void setOrderDis(String orderDis) {
        this.orderDis = orderDis;
    }

    public String getOrderCus() {
        return orderCus;
    }

    public void setOrderCus(String orderCus) {
        this.orderCus = orderCus;
    }

    public int getOrderSta() {
        return orderSta;
    }

    public void setOrderSta(int orderSta) {
        this.orderSta = orderSta;
    }

    public Timestamp getInvoiceDate() {
        return invoiceDate;
    }

    public void setInvoiceDate(Timestamp invoiceDate) {
        this.invoiceDate = invoiceDate;
    }

    public int getTotalOrderPrice() {
        return totalOrderPrice;
    }

    public void setTotalOrderPrice(int totalOrderPrice) {
        this.totalOrderPrice = totalOrderPrice;
    }

    public Set<ordpro> getProductInOrder() {
        return productInOrder;
    }

    public void setProductInOrder(Set<ordpro> productInOrder) {
        this.productInOrder = productInOrder;
    }


}
