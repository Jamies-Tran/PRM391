package Group6.Distribution.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "ordpro")
public class ordpro {

    @EmbeddedId
    private OrderProductID id = new OrderProductID();

    @JsonIgnoreProperties({"image", "stock"})
    @ManyToOne
    @MapsId("productID")
    private product product;

    @JsonIgnore
    @ManyToOne
    @MapsId("orderID")
    @JoinColumn(name = "order_id")
    private order order;

    @Column(name = "totalPrice")
    private int totalPrice;

    @Column(name = "quantity")
    private int quantity;

    @Embeddable
    public static class OrderProductID implements Serializable {
        private static final long serialVersionUID = 1L;

        @Column(name = "product_id")
        private Integer productID;


        @Column(name = "order_id")
        private Integer orderID;

        public OrderProductID() {
        }

        public OrderProductID(Integer product_id, Integer order_id) {
            this.productID = product_id;
            this.orderID = order_id;
        }

        public Integer getProduct_id() {
            return productID;
        }

        public void setProduct_id(Integer product_id) {
            this.productID = product_id;
        }

        public Integer getOrder_id() {
            return orderID;
        }

        public void setOrder_id(Integer order_id) {
            this.orderID = order_id;
        }

    }

    public ordpro() {
    }

    public ordpro(OrderProductID id, Group6.Distribution.model.product product, Group6.Distribution.model.order order, int totalPrice, int quantity) {
        this.id = id;
        this.product = product;
        this.order = order;
        this.totalPrice = totalPrice;
        this.quantity = quantity;
    }

    public Group6.Distribution.model.product getProduct() {
        return product;
    }

    public void setProduct(Group6.Distribution.model.product product) {
        this.product = product;
    }

    public Group6.Distribution.model.order getOrder() {
        return order;
    }

    public void setOrder(Group6.Distribution.model.order order) {
        this.order = order;
    }

    public int getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
