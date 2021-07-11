import 'package:hci_201/modelGrocery/user.dart';

class Order {
  final int id;
  final String orderDis = "Grocery system";
  final String orderCus;
  final int orderStat;
  final String invoiceDate;
  final int totalPrice;
  Users user = Users();

  Order({this.id, this.orderCus, this.orderStat, this.invoiceDate, this.totalPrice});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderCus: json['orderCus'],
      orderStat: json['orderStat'],
      invoiceDate: json['invoiceDate'],
      totalPrice: json['totalPrice']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : this.id,
      'orderCus' : this.orderCus,
      'orderStat' : this.orderStat,
      'invoiceDate' : this.invoiceDate,
      'totalPrice' : this.totalPrice
    };
  }

}