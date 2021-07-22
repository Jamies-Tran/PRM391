import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hci_201/modelGrocery/order.dart';
import 'package:hci_201/modelGrocery/order_product.dart';
import 'package:hci_201/modelGrocery/product.dart';
import 'package:hci_201/modelGrocery/user.dart';
import 'package:hci_201/serviceGrocery/api_service.dart';
import 'package:hci_201/serviceGrocery/database_service.dart';
import 'package:hci_201/shared/text_decoration.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class EditOrder extends StatefulWidget {
  const EditOrder({Key key}) : super(key: key);

  @override
  _EditOrderState createState() => _EditOrderState();
}

class _EditOrderState extends State<EditOrder> {

  final List<String> _cityList = [
    "Hồ Chí Minh",
    "Hà Nội",
    "An Giang",
    "Bạc Liêu",
    "Bến Tre",
    "Bình Phước",
    "Bình Thuận"
  ];

  final ApiService _api = ApiService();

  String _locationValue = "Hồ Chí Minh";

  Product _product;

  DateTime _pickStartDate = DateTime.now().add(Duration(days: 4));

  String _getConfirmDate = "";

  String _datePickerText = "Ấn để chọn ngày";

  bool _isEditDate = false;

  bool _isEditDateDone = false;

  bool _isEditQuantityDone = false;

  bool _isEditQuantity = false;

  bool _isQuantityValid(int _total, int _takeAway) {
    return _total >= _takeAway;
  }

  int _oneQuantity = 24;

  int _sixQuantity = 6 * 24;

  int _tenQuantity = 10 * 24;

  bool _isOneSelected = false;

  bool _isSixSelected = false;

  bool _isTenSelected = false;

  final List<int> _getQuantityChoice = [];

  final _formatPrice = NumberFormat("##,000");

  DocumentSnapshot _orderDoc;

  Order _order;

  OrderProduct _orderProduct;

  // tạo order
  int _totalPrice = 0;

  // tạo order
  Users _user;

  // tạo order
  //String _invoiceDate = formatDate(DateTime.now(), [yyyy, " - ", MM, " - ", dd]);


  int _calculatingRemain() {
    int _totalRemain = 0;
    if(_getQuantityChoice.isNotEmpty) {
      for(var _index in _getQuantityChoice) {
        _totalRemain = _totalRemain + _index;
      }
    }
    return _totalRemain;
  }

  @override
  Widget build(BuildContext context) {
    Map _data = ModalRoute.of(context).settings.arguments;
    _user = _data['user'];
    _product = _data['product'];
    _orderDoc = _data['order'];
    _orderProduct = _data['orderProduct'];
    _order = Order(id: _orderDoc.data['id'], orderCus: _orderDoc.data['order_cus'], orderStat: _orderDoc.data['order_stat'], invoiceDate: _orderDoc.data['invoice_date'], totalPrice: _orderDoc.data['total_price']);
    print("order: ${_order.totalPrice} _ orderproduct: ${_orderProduct.totalPrice}");
    final DBService _database = DBService();
    return Scaffold(
      appBar: myAppBar("Đặt hàng"),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Text("1.Địa điểm giao hàng", style: textStyle30.copyWith(color: Colors.blueGrey)),
                    Text("*", style: textStyle30.copyWith(color: Colors.red)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: DropdownButton(
                        value: _locationValue,
                        underline: Container(
                          height: 2,
                          color: Colors.indigo,
                        ),
                        items: _cityList.map<DropdownMenuItem<String>>((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e, style: textStyle20.copyWith(color: Colors.black45))
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            _locationValue = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextField(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.0
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.lightBlue,
                                  width: 1.0
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1.0
                              ),
                            ),
                            labelText: "điền địa chỉ tại đây",
                            labelStyle: textStyle20.copyWith(color: Colors.black45)
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Text("2.Thời gian", style: textStyle30.copyWith(color: Colors.blueGrey)),
                    Text("*", style: textStyle30.copyWith(color: Colors.red)),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: _isEditDate == true ? Row(
                  children: [
                    ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width * 0.5,
                      height: 50,
                      child: RaisedButton.icon(
                        icon: Icon(Icons.calendar_today_sharp, color: Colors.white),
                        onPressed: () {
                          DatePicker.showDatePicker(
                            context,
                            minTime: _pickStartDate,
                            maxTime: _pickStartDate.add(Duration(days: 21)),
                            locale: LocaleType.vi,
                            onConfirm: (time) {
                              setState(() {
                                _datePickerText = formatDate(time, [yyyy, "-", mm, "-", dd]);
                              });
                            },
                          );
                        },
                        label: Text("$_datePickerText", style: textStyle20.copyWith(color: Colors.white)),
                        color: Colors.grey,
                      ),
                    ),
                    IconButton(icon: Icon(Icons.cancel, color: Colors.red,), onPressed: (){
                      setState(() {
                        _isEditDate = false;
                      });
                    }),
                    IconButton(icon: Icon(Icons.check_circle_outline, color: Colors.green), onPressed: (){
                      setState(() {
                        _getConfirmDate = _datePickerText;
                        _isEditDate = false;
                        _isEditDateDone = true;
                      });
                    })
                  ],
                ) : Row(
                  children: [
                    Text(_isEditDateDone == true ? "$_getConfirmDate" : "${_order.invoiceDate}", style: textStyle25.copyWith(color: _isEditDateDone == true ? Colors.green : Colors.blue)),
                    IconButton(icon: Icon(Icons.edit, color: Colors.black45), onPressed: (){
                      setState(() {
                        _isEditDate = true;
                      });
                    })
                  ],
                )
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Text("3.Số lượng", style: textStyle30.copyWith(color: Colors.blueGrey)),
                    Text("*", style: textStyle30.copyWith(color: Colors.red)),
                  ],
                ),
              ),


               FutureBuilder(
                future: _api.getProductById(_product.id),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    _product = snapshot.data;
                    return Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: _isEditQuantity == true ? Row(
                                children: [
                                  SizedBox(width: 40),
                                  ButtonTheme(
                                    minWidth: MediaQuery.of(context).size.width * 0.23,
                                    height: 50,
                                    child: RaisedButton(
                                      child: Text( "1 thùng", style: textStyle15.copyWith(color: Colors.white)),
                                      color: _product.stock >= _oneQuantity ? _isOneSelected == false ? Colors.grey : Colors.green : Colors.red,
                                      onPressed: () {
                                        setState(() {
                                          _isOneSelected = !_isOneSelected;
                                          if(_isOneSelected == true) {
                                            _getQuantityChoice.add(_oneQuantity);
                                          }else {
                                            _getQuantityChoice.remove(_oneQuantity);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  ButtonTheme(
                                    minWidth: MediaQuery.of(context).size.width * 0.23,
                                    height: 50,
                                    child: RaisedButton(
                                      child: Text( "6 thùng", style: textStyle15.copyWith(color: Colors.white)),
                                      color: _product.stock >= _sixQuantity ? _isSixSelected == false ? Colors.grey : Colors.green : Colors.red,
                                      onPressed: () {
                                        setState(() {
                                          _isSixSelected = !_isSixSelected;
                                          if(_isSixSelected == true) {
                                            _getQuantityChoice.add(_sixQuantity);
                                          }else {
                                            _getQuantityChoice.remove(_sixQuantity);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  ButtonTheme(
                                    minWidth: MediaQuery.of(context).size.width * 0.23,
                                    height: 50,
                                    child: RaisedButton(
                                      child: Text( "10 thùng", style: textStyle15.copyWith(color: Colors.white)),
                                      color: _product.stock >= (_oneQuantity * 6) ? _isTenSelected == false ? Colors.grey : Colors.green : Colors.red,
                                      onPressed: () {
                                        setState(() {
                                          _isTenSelected = !_isTenSelected;
                                          if(_isTenSelected == true) {
                                            _getQuantityChoice.add(_tenQuantity);
                                          }else {
                                            _getQuantityChoice.remove(_tenQuantity);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ) : Container(
                                    child: Row(
                                      children: [
                                        Text("Bạn đã đặt với số lượng: ${_orderProduct.quantity} đơn vị", style: textStyle20.copyWith(color: Colors.blue)),
                                        IconButton(icon: Icon(Icons.edit, color: Colors.black45), onPressed: (){
                                          setState(() {
                                            _isEditQuantity = true;
                                          });
                                        })
                                    ],
                        ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              child: Row(
                                children: [
                                  Icon(Icons.forward, size: 25, color: Colors.red),
                                  SizedBox(width: 10),
                                  Text("Tổng cộng: ${_formatPrice.format(_calculatingRemain() * _product.price)} Vnd", style: textStyle25.copyWith(color: Colors.blueGrey),)
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              child: ButtonTheme(
                                minWidth: MediaQuery.of(context).size.width * 0.5,
                                height: 50,
                                child: RaisedButton(
                                  color: _isQuantityValid(_product.stock, _calculatingRemain()) == true ? Colors.green : Colors.grey,
                                  child: Text(_isQuantityValid(_product.stock, _calculatingRemain()) == true ? "Thêm vào giỏ hàng" : "Kho hàng không đủ", style: textStyle20.copyWith(color: Colors.white)),
                                  onPressed: ()  {
                                    if(_isQuantityValid(_product.stock, _calculatingRemain()) == true) {
                                      setState(() {
                                        _totalPrice = _calculatingRemain() * _product.price;
                                      });
                                      Order _order = Order(totalPrice: _totalPrice, invoiceDate: _getConfirmDate, orderCus: _user.email);
                                      showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          return CupertinoAlertDialog(
                                            title: Text("Xác nhận", style: textStyle20.copyWith(color: Colors.black45)),
                                            content: Container(
                                              padding: EdgeInsets.symmetric(vertical: 20),
                                              child: Center(
                                                child: Text("Xác nhận thay đổi?", style: textStyle20.copyWith(color: Colors.black45)),
                                              ),
                                            ),
                                            actions: [
                                              CupertinoDialogAction(
                                                child: Text("Quay lại"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              CupertinoDialogAction(
                                                child: Text("Xác nhận"),
                                                onPressed: () async {
                                                  int _count = 0;
                                                  String _ordId = "${_user.username}_${_product.id}";
                                                  QuerySnapshot _query = await Firestore.instance.collection('orders').getDocuments();
                                                  for(var _doc in _query.documents) {
                                                    if(_doc.documentID.compareTo(_ordId) == 0) {
                                                      _count = _count + 1;
                                                      _ordId = "${_user.username}_${_product.id}_$_count";
                                                    }
                                                  }
                                                  await _database.editOrder(_orderDoc.documentID, _calculatingRemain(), _getConfirmDate, _product);
                                                  Navigator.pushReplacementNamed(context, "/main");
                                                },
                                              ),
                                            ],
                                          );
                                        },);

                                    }
                                  },
                                ),
                              ),
                            ),

                          ],
                        )
                    );
                  }else {
                    return SpinKitChasingDots(color: Colors.green);
                  }
                },
              )



            ],
          ),
        ),
      ),
    );
  }
}
