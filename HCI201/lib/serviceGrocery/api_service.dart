import 'package:hci_201/modelGrocery/order.dart';
import 'package:hci_201/modelGrocery/product.dart';
import 'package:hci_201/modelGrocery/user_order.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {

  // product api
  Future<List<Product>> getProductList() async {
    List<Product> _proList = [];
    String uri = "http://10.0.2.2:8080/distribution/product/all";
    http.Response response = await http.get(Uri.parse(uri), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var parsedList = jsonDecode(response.body) as List;
      _proList = parsedList.map((e) => Product.fromJson(e)).toList();
      return _proList;
    } else {
      throw Exception("Failed to get product list.");
    }
  }

  Future<Product> getProductById(int id) async {
    String uri = "http://10.0.2.2:8080/distribution/product/$id";
    http.Response response = await http.get(
        Uri.parse(uri));
    if (response.statusCode == 200) {
      Product _getProduct = Product.fromJson(jsonDecode(response.body));
      return _getProduct;
    } else {
      throw Exception("Failed to get product.");
    }
  }

  // order api
  Future createOrder(int id, UserOrder userOrder) async {
    String uri = "http://10.0.2.2:8080/distribution/order/$id/create";
    http.Response response = await http.post(
        Uri.parse(uri), headers: {"Content-Type": "application/json"},
        body: userOrder.toJson());
  }

  Future<Order> getOrderById(int id) async {
    String uri = "http://10.0.2.2:8080/distribution/order/$id";
    http.Response response = await http.get(
        Uri.parse(uri), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      Order order = Order.fromJson(jsonDecode(response.body));
      return order;
    } else {
      throw Exception("Failed to get order");
    }
  }

  Future<List<Order>> getOrderList() async {
    String uri = "http://10.0.2.2:8080/distribution/order/all";
    http.Response response = await http.get(Uri.parse(uri), headers: {"Content-Type" : "application/json"});
    if(response.statusCode == 200) {
      var parsedList = jsonDecode(response.body) as List;
      List<Order> orderList = parsedList.map((e) => Order.fromJson(e));
      return orderList;
    }else {
      throw Exception("Failed to get orderList");
    }
  }

  Future<Order> getOrderDetail(int id) async {
    String uri = "http://10.0.2.2:8080/distribution/order/detail/$id";
    http.Response response = await http.get(Uri.parse(uri), headers: {"Content-Type" : "application/json"});
    if(response.statusCode == 200) {
      Order order = Order.fromJson(jsonDecode(response.body));
      return order;
    }else {
      throw Exception("Failed to get order detail.");
    }
  }
}