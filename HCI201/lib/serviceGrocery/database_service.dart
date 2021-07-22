

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hci_201/modelGrocery/order.dart';
import 'package:hci_201/modelGrocery/order_product.dart';
import 'package:hci_201/modelGrocery/product.dart';
import 'package:hci_201/modelGrocery/user.dart';
import 'package:hci_201/modelGrocery/user_order.dart';

import 'api_service.dart';
import 'api_service.dart';

class DBService {

  final CollectionReference _userCollection = Firestore.instance.collection("users");

  final CollectionReference _orderCollection = Firestore.instance.collection("orders");

  final CollectionReference _orderProductCollection = Firestore.instance.collection("order_product");

  final ApiService _api = ApiService();

  final String uid;

  DBService({this.uid});


  Future registerUserInformation(int id, String email, String username, String password,  int phone, String address, String role) async {
    await _userCollection.document(uid).setData({
      'password' : password,
      'id' : id,
      'email' : email,
      'username' : username,
      'phone' : phone,
      'address' : address,
      'role' : role
    });
    await updateUserId(email).then((value) async {
      Users _user = Users(email: email, username: username, password: password, phone: phone, address: address, role: role);
      return await _api.createAccount(_user);
    });
  }

  Future registerUserInformation2(int id, String email, String username, String password,  int phone, String address, String role) async {
    await _userCollection.document(uid).setData({
      'password' : password,
      'id' : id,
      'email' : email,
      'username' : username,
      'phone' : phone,
      'address' : address,
      'role' : role
    });
    await updateUserId(email);
  }



  Future updateUserInformation(String username,  int phone, String address) async {
    if(username != null && phone == null && address == null) {
      return await _userCollection.document(uid).updateData({'username' : username});
    }else if(username == null && phone != null && address == null) {
      return await _userCollection.document(uid).updateData({'phone' : phone});
    }else if(username == null && phone == null && address != null) {
      return await _userCollection.document(uid).updateData({'address' : address});
    }
  }


  Stream<QuerySnapshot> get userInformation {
    return _userCollection.snapshots();
  }

  Future<DocumentSnapshot> userInformationByUid() {
    return _userCollection.document(uid).get();
  }

  Future<DocumentSnapshot> userInformationByInpUid(String uid) {
    return _userCollection.document(uid).get();
  }

  Future updateUserId(String email) async {
    int id = 0;
    List<DocumentSnapshot> _list = [];
    QuerySnapshot _query = await _userCollection.getDocuments();
    _query.documents.forEach((element) { _list.add(element); });
    _list.sort((a, b) => a.data['id'].compareTo(b.data['id']));
    _list = _list.reversed.toList();
    print(_list[0].data['id']);
    if(_list[0].data['id'] == 0) {
      id = id + 1;
    }else {
      id = _list[0].data['id'] + 1;
    }
    return await _userCollection.document(email).updateData({
      'id': id
    });
  }


  Future addToShoppingCard(String _ordId, Order _order, int _quantity, Product _product) async {
     return await _orderCollection.document(_ordId).setData({
      'id' : 0,
      'order_cus' : _order.orderCus,
      'order_dis' : _order.orderDis,
      'order_stat' : 0,
      'invoice_date' : _order.invoiceDate,
      'total_price' : _product.price,
    }).then((value) async {
       await updateOrderId(_ordId, _product, _quantity, _order.totalPrice);
     });
    // return await updateOrderId(_ordId, _productId, _quantity, _order.totalPrice);
  }

  Future<DocumentSnapshot> getOrderProductByOrderId(int id) async {
    QuerySnapshot _query = await _orderProductCollection.getDocuments();
    for(var _doc in _query.documents) {
      if(_doc.data['order_id'] == id) {
        return _doc;
      }
    }
    return null;
  }

  Future orderInformationByInpOid(String _ordId) {
    return _orderCollection.document(_ordId).get();
  }

  Future updateOrderStatus(String _docId, int _userId , int _statusCode, Product _product) async {
    if(_statusCode == 1) {
      await _orderCollection.document(_docId).updateData({
        'order_stat' : _statusCode
      }).then((value) async {
        DocumentSnapshot _orderDoc = await _orderCollection.document(_docId).get();
        DocumentSnapshot _orderProductDoc = await _orderProductCollection.document(_docId).get();
        OrderProduct _orderProduct = OrderProduct(orderId: _orderProductDoc.data['order_id'], productId: _orderProductDoc.data['product_id'], quantity: _orderProductDoc.data['quantity'], totalPrice: _orderProductDoc.data['total_order_price']);
        Order _order = Order(id: _orderDoc.data['id'], orderCus: _orderDoc.data['order_cus'], invoiceDate: _orderDoc.data['invoice_date'], totalPrice: _orderDoc.data['total_price'], orderStat: _orderDoc.data['order_stat']);
        _product.stock = _product.stock - _orderProduct.quantity;
        _order.totalPrice = _orderProduct.totalPrice;
        print("stock: ${_product.stock} - ID: ${_order.id} - orderCus: ${_order.orderCus} - invoiceDate: ${_order.invoiceDate} - totalPrice: ${_order.totalPrice} - orderStat: ${_order.orderStat}" );
        await _api.createOrder(_userId, _order).then((value) async {
          await _api.updateProduct(_product, _product.id);
        });
      });
    }else {
      await _orderCollection.document(_docId).updateData({
        'order_stat' : _statusCode
      });
    }
  }

  Future updateOrderId(String _orderId, Product _product, int _quantity, int _totalPrice) async {
    int id = 0;
    List<DocumentSnapshot> _list = [];
    QuerySnapshot _query = await _orderCollection.getDocuments();
    _query.documents.forEach((element) {_list.add(element);});
    _list.sort((a, b) => a.data['id'].compareTo(b.data['id']));
    _list = _list.reversed.toList();
    if(_list.length == 1) {
      id = 0;
    }else {
      id = _list[0].data['id'] + 1;
    }
    return await _orderCollection.document(_orderId).updateData({
      'id' : id
    }).then((value) {
      int _totalOrderPrice = _product.price * _quantity;
      _orderProductCollection.document(_orderId).setData({
        'order_id' : id,
        'product_id' : _product.id,
        'quantity' : _quantity,
        'total_order_price' : _totalOrderPrice,
      });
    });
  }

  Future editOrder(String _docId, int _quantity, String _invoiceDate, Product _product) async {
    int _totalOrderPrice = _quantity * _product.price;
    int _remainStock = _product.stock - _quantity;
    return await _orderCollection.document(_docId).updateData({
      "invoice_date" : _invoiceDate
    }).then((value) async {
      await _orderProductCollection.document(_docId).updateData({
        "quantity" : _quantity,
        "total_order_price" : _totalOrderPrice
      });
    });
  }


  Future<QuerySnapshot> getOrderList() async {
    QuerySnapshot _query = await _orderCollection.getDocuments();
    return _query;
  }

}