import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hci_201/modelGrocery/order_product.dart';
import 'package:hci_201/modelGrocery/product.dart';
import 'package:hci_201/modelGrocery/user.dart';
import 'package:hci_201/serviceGrocery/database_service.dart';
import 'package:hci_201/shared/text_decoration.dart';
import 'package:intl/intl.dart';

import '../modelGrocery/order.dart';
import '../serviceGrocery/api_service.dart';
import '../shared/text_decoration.dart';
import '../shared/text_decoration.dart';
import '../shared/text_decoration.dart';
import '../shared/text_decoration.dart';

class ViewOrder extends StatefulWidget {

  final Users user;

  ViewOrder({this.user});

  @override
  _ViewOrderState createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {

  bool _isNewOrderScreen = true;

  Product _product;

  @override
  Widget build(BuildContext context) {
    final DBService _database = DBService(uid: widget.user.email);
    final ApiService _api = ApiService();
    final _formatPrice = NumberFormat("##,000");

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width * 0.5,
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          _isNewOrderScreen = true;
                        });
                      },
                      color: _isNewOrderScreen == true ? Colors.lightBlueAccent : Colors.white,
                      child: Text("Giỏ hàng", style: TextStyle(fontSize: 20, fontFamily: 'robo', fontWeight: FontWeight.bold, color: _isNewOrderScreen == true ? Colors.white : Colors.lightBlueAccent)),
                    )
                ),
                ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width * 0.5,
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          _isNewOrderScreen = false;
                        });
                      },
                      color: _isNewOrderScreen == false ? Colors.lightBlueAccent : Colors.white,
                      child: Text("Hoàn thành", style: TextStyle(fontSize: 20, fontFamily: 'robo', fontWeight: FontWeight.bold, color: _isNewOrderScreen == false ? Colors.white : Colors.lightBlueAccent)),
                    )
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              height: MediaQuery.of(context).size.height * 0.75,
              child: FutureBuilder(
                future: _database.getOrderList(),
                builder: (context, orderSnapshot) {
                  if(orderSnapshot.hasData) {
                    List<DocumentSnapshot> _containList = [];
                    List<DocumentSnapshot> _orderList = [];
                    List<DocumentSnapshot> _ongoingOrderList = [];
                    List<DocumentSnapshot> _finishedOrderList = [];
                    _containList.addAll(orderSnapshot.data.documents);
                    _containList = _containList.where((element) => element.data['order_cus'].compareTo(widget.user.email) == 0).toList();
                    _ongoingOrderList.addAll(_containList.where((element) => element.data['order_stat'] <= 1));
                    _finishedOrderList.addAll(_containList.where((element) => element.data['order_stat'] > 1));
                    _orderList = _isNewOrderScreen == true ? _ongoingOrderList : _finishedOrderList;

                    return ListView.builder(
                        itemCount: _orderList.length,
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                              future: _database.getOrderProductByOrderId(_orderList[index].data['id']),
                              builder: (context, orderProductSnapshot) {
                                if(orderProductSnapshot.hasData) {
                                  return FutureBuilder(
                                      future: _api.getProductById(orderProductSnapshot.data['product_id']),
                                      builder: (context, productSnapshot) {
                                        if(productSnapshot.hasData) {
                                          _product = productSnapshot.data;
                                          Order _order = Order(id: _orderList[index].data['id'], orderCus: _orderList[index].data['order_cus'], orderStat: _orderList[index].data['order_stat'], invoiceDate: _orderList[index].data['invoice_date'], totalPrice: _orderList[index].data['total_price']);
                                          OrderProduct _orderProduct = OrderProduct(orderId: orderProductSnapshot.data['order_id'], productId: orderProductSnapshot.data['product_id'], totalPrice: orderProductSnapshot.data['total_order_price'], quantity: orderProductSnapshot.data['quantity']);
                                          print("${_product.name}");
                                          return Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(context, "/edit_order", arguments: {
                                                    'product' : _product,
                                                    'user' : widget.user,
                                                    'order' : _orderList[index],
                                                    'orderProduct' : _orderProduct
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.75,
                                                      height: 190,
                                                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage("${productSnapshot.data.image}"), fit: BoxFit.cover)),
                                                    ),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.75,
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey[200],
                                                            offset: Offset(1.0, 1.0),
                                                            spreadRadius: 2.0,
                                                            blurRadius: 2.0
                                                          )
                                                        ]
                                                      ),
                                                      height: 190,
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text("Sản phẩm: ", style: textStyle20.copyWith(color: Colors.black)),
                                                              Text("${productSnapshot.data.name}", style: textStyle20.copyWith(color: Colors.black45))
                                                            ],
                                                          ),
                                                          SizedBox(height: 5),
                                                          Row(
                                                            children: [
                                                              Text("Nhà phân phối: ", style: textStyle20.copyWith(color: Colors.black)),
                                                              Text("${_orderList[index].data['order_dis']}", style: textStyle20.copyWith(color: Colors.black45))
                                                            ],
                                                          ),
                                                          SizedBox(height: 5),
                                                          Row(
                                                            children: [
                                                              Text("Ngày nhận hàng: ", style: textStyle20.copyWith(color: Colors.black)),
                                                              Text("${_orderList[index].data['invoice_date']}", style: textStyle20.copyWith(color: Colors.black45))
                                                            ],
                                                          ),
                                                          SizedBox(height: 5),
                                                          Row(
                                                            children: [
                                                              Text("Số lượng: ", style: textStyle20.copyWith(color: Colors.black)),
                                                              Text("${orderProductSnapshot.data['quantity']} / đơn vị", style: textStyle20.copyWith(color: Colors.black45))
                                                            ],
                                                          ),
                                                          SizedBox(height: 5),
                                                          Row(
                                                            children: [
                                                              Text("Giá: ", style: textStyle20.copyWith(color: Colors.black)),
                                                              Text("${_formatPrice.format(orderProductSnapshot.data['total_order_price'])}VND", style: textStyle20.copyWith(color: Colors.black45))
                                                            ],
                                                          ),
                                                          SizedBox(height: 5),
                                                          Row(
                                                            children: [
                                                              Text("Trạng thái: ", style: textStyle20.copyWith(color: Colors.black)),
                                                              Text("${statusOrder[_orderList[index].data['order_stat']]}", style: textStyle20.copyWith(color:
                                                              _orderList[index].data['order_stat'] == 0 ? Colors.lightBlueAccent : _orderList[index].data['order_stat'] == 1 ? Colors.amber : _orderList[index].data['order_stat'] == 2 ? Colors.red : Colors.lightGreenAccent
                                                              ))
                                                            ],
                                                          ),
                                                          SizedBox(height: 5),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              _orderList[index].data['order_stat'] == 0 ? Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(icon: Icon(Icons.cancel, size: 50, color: Colors.red), onPressed: () async {
                                                      showDialog(
                                                        context: context,
                                                        builder: (dialogContext) {
                                                          return CupertinoAlertDialog(
                                                            title: Text("Xác nhận", style: textStyle20.copyWith(color: Colors.black)),
                                                            content: Container(
                                                              child: Text("Bạn có bỏ khỏi giỏ hàng không?", style: textStyle20.copyWith(color: Colors.black45)),
                                                            ),
                                                            actions: [
                                                              CupertinoDialogAction(
                                                                child: Text("Quay lại", style: textStyle20),
                                                                onPressed: () {
                                                                  Navigator.pop(context);
                                                                },
                                                              ),
                                                              CupertinoDialogAction(
                                                                child: Text("Xác nhận", style: textStyle20),
                                                                onPressed: () async {
                                                                  // Order _order = Order(id: _orderList[index].data['id'], orderCus: _orderList[index].data['order_cus'], invoiceDate: _orderList[index].data['invoice_date'], totalPrice: _orderList[index].data['total_price'], orderStat: _orderList[index].data['order_stat']);
                                                                  // //print(" uid:${widget.user.id} _ ID: ${_order.id} - orderCus: ${_order.orderCus} - invoiceDate: ${_order.invoiceDate} - totalPrice: ${_order.totalPrice} - orderStat: ${_order.orderStat}" );
                                                                  // print("${widget.user.id}");
                                                                  // await _api.createOrder(widget.user.id, _order);
                                                                  await _database.updateOrderStatus(_orderList[index].documentID, widget.user.id, 2, _product);
                                                                  Navigator.pushReplacementNamed(context, "/main");
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    }),
                                                    SizedBox(width: 20),
                                                    IconButton(icon: Icon(Icons.check_circle, size: 50, color: Colors.green), onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (dialogContext) {
                                                            return CupertinoAlertDialog(
                                                              title: Text("Xác nhận", style: textStyle20.copyWith(color: Colors.black)),
                                                              content: Container(
                                                                child: Text("Bạn có muốn đặt hàng?", style: textStyle20.copyWith(color: Colors.black45)),
                                                              ),
                                                              actions: [
                                                                CupertinoDialogAction(
                                                                    child: Text("Quay lại", style: textStyle20),
                                                                  onPressed: () {
                                                                      Navigator.pop(context);
                                                                  },
                                                                ),
                                                                CupertinoDialogAction(
                                                                    child: Text("Xác nhận", style: textStyle20),
                                                                  onPressed: () async {
                                                                    // Order _order = Order(id: _orderList[index].data['id'], orderCus: _orderList[index].data['order_cus'], invoiceDate: _orderList[index].data['invoice_date'], totalPrice: _orderList[index].data['total_price'], orderStat: _orderList[index].data['order_stat']);
                                                                    // //print(" uid:${widget.user.id} _ ID: ${_order.id} - orderCus: ${_order.orderCus} - invoiceDate: ${_order.invoiceDate} - totalPrice: ${_order.totalPrice} - orderStat: ${_order.orderStat}" );
                                                                    // print("${widget.user.id}");
                                                                    // await _api.createOrder(widget.user.id, _order);
                                                                      await _database.updateOrderStatus(_orderList[index].documentID, widget.user.id, 1, _product);
                                                                      Navigator.pushReplacementNamed(context, "/main");
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                      );
                                                    }),
                                                  ],
                                                ) : SizedBox(),
                                              SizedBox(height: 20)
                                            ],
                                          );
                                        }else {
                                          return Text("Loading...", style: textStyle20.copyWith(color: Colors.blueAccent));
                                        }
                                      },
                                  );
                                }else  {
                                  return SpinKitChasingDots(color: Colors.green);
                                }
                              },
                          );
                        },
                    );
                  }else {
                    return SpinKitChasingDots(color: Colors.green);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
