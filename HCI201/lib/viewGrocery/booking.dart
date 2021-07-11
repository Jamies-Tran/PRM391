import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

  int id;

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
    id = _data['productId'];
    _api.getProductById(id).then((value) {
      setState(() {
        _product = value;
      });
    });
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
                  child: Text("Thông tin mặt hàng", style: textStyle25.copyWith(color: Colors.blueGrey)),
                ),
                FutureBuilder(
                    future: _api.getProductById(id),
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
                                  Text("${_product.price ~/ 1000}.000 VND", style: textStyle20.copyWith(color: Colors.green))
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

              ],
            ),
          )
      ),
    );
  }
}
