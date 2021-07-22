import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:hci_201/modelGrocery/order.dart';
import 'package:hci_201/modelGrocery/product.dart';
import 'package:hci_201/modelGrocery/user.dart';
import 'package:hci_201/modelGrocery/user_order.dart';
import 'package:hci_201/modelGrocery/sales_report.dart';
import 'package:http/http.dart' as http;

import '../modelGrocery/sales_report.dart';
import '../modelGrocery/sales_report.dart';
import '../modelGrocery/sales_report.dart';

class ApiService {

  // product api
  Future<List<Product>> getProductList() async {
    List<Product> _proList = [];
    String uri = "https://grocer.azurewebsites.net/distribution/product/all";
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
    String uri = "https://grocer.azurewebsites.net/distribution/product/$id";
    http.Response response = await http.get(
        Uri.parse(uri));
    if (response.statusCode == 200) {
      Product _getProduct = Product.fromJson(jsonDecode(response.body));
      return _getProduct;
    } else {
      throw Exception("Failed to get product.");
    }
  }

  Future updateProduct(Product _product, int _id) async {
    String url = "https://grocer.azurewebsites.net/distribution/product/$_id";
    return await http.put(Uri.parse(url), headers: {"Content-Type" : "application/json"}, body: jsonEncode(_product.toJson()));
  }

  Future<Product> getProductByBarcode(String barcode) async {
    String uri = "https://grocer.azurewebsites.net/distribution/product/$barcode";
    http.Response response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      Product _getProduct = Product.fromJson(jsonDecode(response.body));
      return _getProduct;
    } else {
      throw Exception("Failed to get product.");
    }
  }

  // Sales Report
  Future addSalesReportRecord(SalesReport salesReport) async {
    String uri = "https://grocer.azurewebsites.net/distribution/salesReport/create";
    http.Response response = await http.post(
        Uri.parse(uri), headers: {"Content-Type": "application/json"},
        body: salesReport.toJson());
  }

  Future<List<SalesReport>> getSalesReportByDate(String date) async {
    String uri = "https://grocer.azurewebsites.net/distribution/salesReport/$date";
    http.Response response = await http.get(Uri.parse(uri));
    List<SalesReport> _saleReportList = [];
    if (response.statusCode == 200) {
      //SalesReport _getSalesReport = SalesReport.fromJson(jsonDecode(response.body));
      var parseList = jsonDecode(response.body) as List;
      _saleReportList = parseList.map((e) => SalesReport.fromJson(e));
      return _saleReportList;
    } else {
      throw Exception("Failed to get sales report.");
    }
  }

  Future<SalesReport> getsalesReportByBarcode(String barcode) async {
    String uri = "https://grocer.azurewebsites.net/distribution/salesReport/$barcode";
    http.Response response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      SalesReport _getSalesReport = SalesReport.fromJson(jsonDecode(response.body));
      return _getSalesReport;
    } else {
      throw Exception("Failed to get product.");
    }
  }

  // order api
  Future createOrder(int id, Order order) async {
    String uri = "https://grocer.azurewebsites.net/distribution/order/$id/create";
    return await http.post(
        Uri.parse(uri), headers: {'Content-Type' : "application/json"},body: jsonEncode(order.toJson()));
  }

  Future<Order> getOrderById(int id) async {
    String uri = "https://grocer.azurewebsites.net/distribution/order/$id";
    http.Response response = await http.get(
        Uri.parse(uri), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      Order order = Order.fromJson(jsonDecode(response.body));
      return order;
    } else {
      throw Exception("Failed to get order");
    }
  }

  Future updateOrderStatus(int id, Order _order) async {
    String uri = "https://grocer.azurewebsites.net/distribution/order/status/$id";
    return await http.put(Uri.parse(uri), headers: {"Content-Type" : "application/json"}, body: jsonEncode(_order.toJson()));
  }

  Future createAccount(Users _user) async {
    String uri = "https://grocer.azurewebsites.net/distribution/user/create";
    return await http.post(Uri.parse(uri), headers: {'Content-Type' : "application/json"}, body: jsonEncode(_user.toJson()));
  }

  Future updateAccount(Users _user, int _id) async {
    String url = "https://grocer.azurewebsites.net/distribution/user/$_id";
    return await http.put(Uri.parse(url), headers: {"Content-Type" : "application/json"}, body: jsonEncode(_user.toJson()));
  }

  Future<List<Order>> getOrderList() async {
    String uri = "https://grocer.azurewebsites.net/distribution/order/all";
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
    String uri = "https://grocer.azurewebsites.net/distribution/order/detail/$id";
    http.Response response = await http.get(Uri.parse(uri), headers: {"Content-Type" : "application/json"});
    if(response.statusCode == 200) {
      Order order = Order.fromJson(jsonDecode(response.body));
      return order;
    }else {
      throw Exception("Failed to get order detail.");
    }
  }
}