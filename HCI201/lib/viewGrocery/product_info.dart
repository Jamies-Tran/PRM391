import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hci_201/modelGrocery/product.dart';
import 'package:hci_201/modelGrocery/user.dart';
import 'package:hci_201/serviceGrocery/api_service.dart';
import 'package:hci_201/shared/text_decoration.dart';
import 'package:intl/intl.dart';



class ProductInfo extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<ProductInfo> {

  ApiService _api = ApiService();

  Product _product;

  int _id;

  Users _user;

  // String _dateTimeNow;
  //
  // String _dateTimePicker = "__/__/____";

  final List<Product> _productList = [];



  String _selectLocation = "Hồ Chí Minh";

  int _index = 0;

  final _formatPrice = NumberFormat("##,000");

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
    _user = _data['user'];
    return Scaffold(
      appBar: myAppBar("Thông tin sản phẩm"),
      body: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                FutureBuilder(
                    future: _api.getProductById(_id),
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {
                        _product = snapshot.data;
                        List<String> _pictureList = List.generate(10, (index) => "${_product.image}");
                        //List<String> _pictureList = ["assets/aqua.jpg", "assets/coca.jpg"];
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  Text("1.Hình ảnh", style: textStyle30.copyWith(color: Colors.blueGrey))
                                ],
                              ),
                            ),
                            // ảnh
                            Container(
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.arrow_back_ios, color: Colors.green),
                                    iconSize: 30,
                                    onPressed: () {
                                      setState(() {
                                        if(_index > 0) {
                                          _index = _index - 1;
                                        }
                                      });
                                    },
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.75,
                                    height: MediaQuery.of(context).size.height * 0.5,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage("${_pictureList[_index]}"),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.arrow_forward_ios, color: Colors.green),
                                    iconSize: 30,
                                    onPressed: () {
                                      setState(() {
                                        if(_index < _pictureList.length - 1) {
                                          _index = _index + 1;
                                          print("$_index");
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              child: Text("${_index + 1}/${_pictureList.length} ", style: textStyle20.copyWith(color: Colors.blueGrey)),
                            ),

                            SizedBox(height: 30),

                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  Text("2.Chi tiết", style: textStyle30.copyWith(color: Colors.blueGrey))
                                ],
                              ),
                            ),
                            // tên
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  Text("Tên: ", style: textStyle20.copyWith(color: Colors.indigo)),
                                  Text("${_product.name}", style: textStyle20.copyWith(color: Colors.black45))
                                ],
                              ),
                            ),

                            // loại mặt hàng
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  Text("Loại mặt hàng: ", style: textStyle20.copyWith(color: Colors.indigo)),
                                  Text("${_getProductCategoryVN(_product.category)}", style: textStyle20.copyWith(color: Colors.black45))
                                ],
                              ),
                            ),

                            // giá
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  Text("Giá: ", style: textStyle20.copyWith(color: Colors.indigo)),
                                  Text("${_formatPrice.format(_product.price)}VND / 1 lon", style: textStyle20.copyWith(color: Colors.black45))
                                ],
                              ),
                            ),

                            // tồn kho
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  Text("Tồn kho: ", style: textStyle20.copyWith(color: Colors.indigo)),
                                  Text("${_product.stock}", style: textStyle20.copyWith(color: Colors.black45))
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

                SizedBox(height: 30),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Text("3.Những sản phẩm liên quan", style: textStyle30.copyWith(color: Colors.blueGrey))
                    ],
                  ),
                ),

                SizedBox(height: 10),

                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: FutureBuilder(
                      future: _api.getProductList(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData) {
                          _productList.addAll(snapshot.data.where((e) => e.category.compareTo(_product.category) == 0));
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _productList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(context, "/product_info", arguments: {
                                    'productId' : _productList[index].id,
                                    'user' : _user
                                  });
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.5,
                                  width: MediaQuery.of(context).size.width * 0.75,
                                  padding: EdgeInsets.fromLTRB(0, 300, 0, 0),
                                  margin: EdgeInsets.fromLTRB(0, 0, 25, 0),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("${_productList[index].image}"),
                                          fit: BoxFit.cover
                                      )
                                  ),
                                  child: Container(
                                    color: Colors.black54,
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("Tên sản phẩm: " , style: textStyle20.copyWith(color: Colors.white)),
                                            Text("${_productList[index].name}" , style: textStyle20.copyWith(color: Colors.white)),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("Giá: " , style: textStyle20.copyWith(color: Colors.white)),
                                            Text("${_formatPrice.format(_productList[index].price)} VND", style: textStyle20.copyWith(color: Colors.white)),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("Tồn kho: " , style: textStyle20.copyWith(color: Colors.white)),
                                            Text("${_productList[index].stock}", style: textStyle20.copyWith(color: Colors.white)),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }else {
                          return SpinKitChasingDots(color: Colors.green);
                        }
                      },
                  ),
                ),

                Center(
                  child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width * 0.5,
                    height: 50,
                    child: RaisedButton(
                      color: Colors.green,
                      onPressed: () {
                        print(_product.id);
                        Navigator.pushNamed(context, "/booking", arguments: {
                          "user" : _user,
                          "product" : _product
                        });
                      },
                      child: Text("Đặt hàng", style: textStyle20.copyWith(color: Colors.white),),
                    ),
                  ),
                ),

                SizedBox(height: 30)
              ],
            ),
          )
      ),
    );
  }
}
