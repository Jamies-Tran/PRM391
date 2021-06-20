package Group6.Distribution.model;

import java.sql.Timestamp;
import java.util.List;

public class customOrd {

    private String orderDis;
    private String orderCus;
    private int orderSta;
    private Timestamp invoiceDate;

    public static class listProduct {
        private int proID;
        private int quantity;

        public listProduct() {
        }

        public listProduct(int proID) {
            this.proID = proID;
        }

        public listProduct(int proID, int quantity) {
            this.proID = proID;
            this.quantity = quantity;
        }

        public int getProID() {
            return proID;
        }

        public void setProID(int proID) {
            this.proID = proID;
        }

        public int getQuantity() {
            return quantity;
        }

        public void setQuantity(int quantity) {
            this.quantity = quantity;
        }
    }

    private List<listProduct> productInOrder;

    public customOrd() {
    }

    public customOrd(String orderDis, String orderCus, int orderSta, Timestamp invoiceDate, List<listProduct> productInOrder) {
        this.orderDis = orderDis;
        this.orderCus = orderCus;
        this.orderSta = orderSta;
        this.invoiceDate = invoiceDate;
        this.productInOrder = productInOrder;
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

    public List<listProduct> getProductInOrder() {
        return productInOrder;
    }


    public void setProductInOrder(List<listProduct> productInOrder) {
        this.productInOrder = productInOrder;
    }
}
