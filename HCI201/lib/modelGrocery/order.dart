import 'package:hci_201/modelGrocery/order_product.dart';
import 'package:hci_201/modelGrocery/product.dart';
import 'package:hci_201/modelGrocery/user.dart';

class Order {
  int id;
  String orderDis = "Grocery system";
  String orderCus;
  int orderStat;
  String invoiceDate;
  int totalPrice;

  final List<OrderProduct> ordProductList = [];

  Order({this.id, this.orderCus, this.orderStat, this.invoiceDate, this.totalPrice});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderCus: json['orderCus'],
      orderStat: json['orderStat'],
      invoiceDate: json['invoiceDate'],
      totalPrice: json['totalOrderPrice']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id" : this.id,
      'orderCus' : this.orderCus,
      'orderSta' : this.orderStat,
      'invoiceDate' : this.invoiceDate,
      'totalOrderPrice' : this.totalPrice,
      'orderDis' : this.orderDis,
      'productInOrder' : this.ordProductList
    };
  }

}