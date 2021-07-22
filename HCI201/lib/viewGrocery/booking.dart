import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hci_201/modelGrocery/order.dart';
import 'package:hci_201/modelGrocery/product.dart';
import 'package:hci_201/modelGrocery/user.dart';
import 'package:hci_201/serviceGrocery/api_service.dart';
import 'package:hci_201/serviceGrocery/database_service.dart';
import 'package:hci_201/shared/text_decoration.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class Booking extends StatefulWidget {
  const Booking({Key key}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {

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

  // tạo order
  int _totalPrice = 0;

  // tạo order
  Users _user;

  // tạo order
  String _invoiceDate = formatDate(DateTime.now(), [yyyy, " - ", MM, " - ", dd]);


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
                    Text("1.Thời gian", style: textStyle30.copyWith(color: Colors.blueGrey)),
                    Text("*", style: textStyle30.copyWith(color: Colors.red)),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
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
                                _getConfirmDate = _datePickerText;
                                print("$_getConfirmDate");
                              });
                            },
                          );
                        },
                        label: Text("$_datePickerText", style: textStyle20.copyWith(color: Colors.white)),
                        color: Colors.grey,
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
                    Text("2.Số lượng", style: textStyle30.copyWith(color: Colors.blueGrey)),
                    Text("*", style: textStyle30.copyWith(color: Colors.red)),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text("*1 thùng gồm 24 đơn vị", style: textStyle15.copyWith(color: Colors.red)),
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
                              child: Row(
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
                                    if(_calculatingRemain() == 0 || _getConfirmDate == "") {
                                      showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return CupertinoAlertDialog(
                                              title: Text("Thiếu thông tin", style: textStyle20.copyWith(color: Colors.black45)),
                                              content: Container(
                                                child: Center(
                                                  child: Text("Vui lòng điền đủ thông tin", style: textStyle20.copyWith(color: Colors.black45)),
                                                ),
                                              ),
                                              actions: [
                                                CupertinoDialogAction(
                                                    child: Text("Chấp nhận"),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                )
                                              ],
                                            );
                                          },
                                      );
                                    }else if(_user.address == null || _user.phone == 0) {
                                      showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          return CupertinoAlertDialog(
                                            title: Text("Xác nhận", style: textStyle20.copyWith(color: Colors.black45)),
                                            content: Container(
                                              padding: EdgeInsets.symmetric(vertical: 20),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(vertical: 20),
                                                child: Text("Bạn chưa cập nhật sđt và địa chỉ", style: textStyle20.copyWith(color: Colors.black45)),
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
                                                child: Text("Cập nhật"),
                                                onPressed: ()  {
                                                  Navigator.pushReplacementNamed(context, "/main");
                                                },
                                              ),
                                            ],
                                          );
                                        },);
                                    }else if(_isQuantityValid(_product.stock, _calculatingRemain()) == true) {
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
                                                child: Text("Bạn có muốn thêm vào giỏ hàng?", style: textStyle20.copyWith(color: Colors.black45)),
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
                                                  await _database.addToShoppingCard("$_ordId", _order, _calculatingRemain(), _product);
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
              ),



            ],
          ),
        ),
      ),
    );
  }
}
