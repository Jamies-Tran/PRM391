import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hci_201/modelGrocery/product.dart';
import 'package:hci_201/serviceGrocery/api_service.dart';
import 'package:hci_201/shared/text_decoration.dart';


class Booking extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {

  ApiService _api = ApiService();

  Product _product;

  int _id;

  String _userUid;

  String _dateTimeNow;

  String _dateTimePicker = "__/__/____";

  String _getProductCategoryVN(String _category) {
    if(_category.compareTo("Water") == 0) {
      return "Nước uống";
    }else if(_category.compareTo("Snack") == 0) {
      return "Bánh snack";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Map _data = ModalRoute.of(context).settings.arguments;
    _id = _data['productId'];
    _userUid = _data['userUid'];
    _dateTimeNow = formatDate(DateTime.now(), [dd, "/", mm, "/", yyyy]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking", style: textStyle20),
        centerTitle: true,
      ),
      body: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text("Thông tin sản phẩm", style: textStyle25.copyWith(color: Colors.blueGrey)),
                ),
                FutureBuilder(
                    future: _api.getProductById(_id),
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {
                        _product = snapshot.data;
                        return Column(
                          children: [
                            // tên
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  Text("Tên: ", style: textStyle20.copyWith(color: Colors.blueGrey)),
                                  Text("${_product.name}", style: textStyle20.copyWith(color: Colors.green))
                                ],
                              ),
                            ),

                            // loại mặt hàng
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  Text("Loại mặt hàng: ", style: textStyle20.copyWith(color: Colors.blueGrey)),
                                  Text("${_getProductCategoryVN(_product.category)}", style: textStyle20.copyWith(color: Colors.green))
                                ],
                              ),
                            ),

                            // giá
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  Text("Giá: ", style: textStyle20.copyWith(color: Colors.blueGrey)),
                                  Text("${_product.price ~/ 1000}.000 VND / 1 lon", style: textStyle20.copyWith(color: Colors.green))
                                ],
                              ),
                            ),

                            // tồn kho
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  Text("Tồn kho: ", style: textStyle20.copyWith(color: Colors.blueGrey)),
                                  Text("${_product.stock}", style: textStyle20.copyWith(color: Colors.green))
                                ],
                              ),
                            ),
                          ],
                        );
                      }else {
                        return SpinKitChasingDots(color: Colors.green);
                      }
                    }
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text("Thông tin đơn hàng", style: textStyle25.copyWith(color: Colors.blueGrey)),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Text("Ngày đặt đơn: ", style: textStyle20.copyWith(color: Colors.blueGrey)),
                      Text("$_dateTimeNow", style: textStyle20.copyWith(color: Colors.green))
                    ],
                  ),
                ),

                // hẹn ngày giao hàng
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ngày giao hàng: (click ô bên dưới để chọn ngày) ", style: textStyle20.copyWith(color: Colors.blueGrey)),
                      RaisedButton.icon(
                          onPressed: () {
                            DatePicker.showDatePicker(
                                context,
                                showTitleActions: true,
                                currentTime: DateTime.now(),
                                minTime: DateTime.now(),
                                maxTime: DateTime.now().add(Duration(days: 28)),
                                onConfirm: (time) {
                                  setState(() {
                                    _dateTimePicker = formatDate(time, [dd, "/", mm, "/", yyyy]);
                                  });
                                },
                            );
                          },
                          icon: Icon(Icons.calendar_today_rounded, color: Colors.white),
                          label: Text("$_dateTimePicker", style: textStyle20.copyWith(color: Colors.white),),
                          color: Colors.green,
                      )
                    ],
                  ),
                ),


                //chọn số lượng
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Text("Chọn số lượng: ", style: textStyle20.copyWith(color: Colors.blueGrey)),
                      Icon(Icons.arrow_back_ios, color: Colors.green,)
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width * 0.5,
                      height: 100,
                      child: RaisedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.shopping_cart, color: Colors.white, size: 20),
                        label: Text("Đặt hàng", style: textStyle20.copyWith(color: Colors.white)),
                        color: Colors.green,
                      )
                  ),
                ),

              ],
            ),
          )
      ),
    );
  }
}
