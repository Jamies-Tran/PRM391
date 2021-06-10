package Group6.Distribution.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "product")
public class product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "name")
    private String name;

    @Column(name = "code")
    private String code;

    @Column(name = "category")
    private String category;

    @Column(name = "price")
    private int price;

    @Column(name = "stock")
    private int stock;

    @Column(name = "image")
    private String image;
    @JsonIgnore
    @OneToMany(mappedBy = "product")
    private Set<ordpro> OrderWithProduct = new HashSet<>();

    public product() {}

    public product(Integer id, String name, String code, String category, int price, int stock, String image) {
        this.id = id;
        this.name = name;
        this.code = code;
        this.category = category;
        this.price = price;
        this.stock = stock;
        this.image = image;
    }

    public product(Integer id, String name, String code, String category, int price, int stock, String image, Set<ordpro> orderWithProduct) {
        this.id = id;
        this.name = name;
        this.code = code;
        this.category = category;
        this.price = price;
        this.stock = stock;
        this.image = image;
        OrderWithProduct = orderWithProduct;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
//
//    public Set<ordpro> getOrderWithProduct() {
//        return OrderWithProduct;
//    }
//
//    public void setOrderWithProduct(Set<ordpro> orderWithProduct) {
//        OrderWithProduct = orderWithProduct;
//    }
}
