import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hci_201/modelGrocery/product.dart';
import 'package:hci_201/modelGrocery/sales_report.dart';
import 'package:hci_201/serviceGrocery/api_service.dart';
import 'package:hci_201/shared/text_decoration.dart';

class SalesReportScreen extends StatefulWidget {
  @override
  _SalesReportScreenState createState() => _SalesReportScreenState();
}

class _SalesReportScreenState extends State<SalesReportScreen> {

  ApiService _api = ApiService();

  List<SalesReport> _waterProductList = [];
  List<SalesReport> _snackProductList = [];

  @override
  Widget build(BuildContext context) {
    Map _data = ModalRoute.of(context).settings.arguments;
    String date = _data['date'];
    // _api.getProductById(id).then((value) {
    //   setState(() {
    //     _product = value;
    //   });
    // });

    return Container(
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              //Bverages
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text("1 - Nước uống", style: textStyle25.copyWith(color: Colors.blueGrey)),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: FutureBuilder(
                  future: _api.getSalesReportByDate(date),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      _waterProductList.addAll(snapshot.data.where((value) => value.category.compareTo("Water") == 0));
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _waterProductList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 0.75,
                              padding: EdgeInsets.fromLTRB(0, 300, 0, 0),
                              margin: EdgeInsets.fromLTRB(0, 0, 25, 0),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("${_waterProductList[index].image}"),
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
                                        Text("Mã sản phẩm: " , style: textStyle20.copyWith(color: Colors.white)),
                                        Text("${_waterProductList[index].prodCode}" , style: textStyle20.copyWith(color: Colors.white)),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Tên sản phẩm: " , style: textStyle20.copyWith(color: Colors.white)),
                                        Text("${_waterProductList[index].prodName}" , style: textStyle20.copyWith(color: Colors.white)),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Giá: " , style: textStyle20.copyWith(color: Colors.white)),
                                        Text("${_waterProductList[index].price~/1000}.000 VND", style: textStyle20.copyWith(color: Colors.white)),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Số lượng: " , style: textStyle20.copyWith(color: Colors.white)),
                                        Text("${_waterProductList[index].qty}", style: textStyle20.copyWith(color: Colors.white)),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Thành tiền: " , style: textStyle20.copyWith(color: Colors.white)),
                                        Text("${_waterProductList[index].amount}", style: textStyle20.copyWith(color: Colors.white)),
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

              // Snacks
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text("2 - Snack", style: textStyle25.copyWith(color: Colors.blueGrey)),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: FutureBuilder(
                  future: _api.getSalesReportByDate(date),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      _snackProductList.addAll(snapshot.data.where((value) => value.category.compareTo("Snack") == 0));
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _snackProductList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 0.75,
                              padding: EdgeInsets.fromLTRB(0, 300, 0, 0),
                              margin: EdgeInsets.fromLTRB(0, 0, 25, 0),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("${_snackProductList[index].image}"),
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
                                        Text("Mã sản phẩm: " , style: textStyle20.copyWith(color: Colors.white)),
                                        Text("${_snackProductList[index].prodCode}" , style: textStyle20.copyWith(color: Colors.white)),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Tên sản phẩm: " , style: textStyle20.copyWith(color: Colors.white)),
                                        Text("${_snackProductList[index].prodName}" , style: textStyle20.copyWith(color: Colors.white)),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Giá: " , style: textStyle20.copyWith(color: Colors.white)),
                                        Text("${_snackProductList[index].price~/1000}.000 VND", style: textStyle20.copyWith(color: Colors.white)),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Số lượng: " , style: textStyle20.copyWith(color: Colors.white)),
                                        Text("${_snackProductList[index].qty}", style: textStyle20.copyWith(color: Colors.white)),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Thành tiền: " , style: textStyle20.copyWith(color: Colors.white)),
                                        Text("${_snackProductList[index].amount}", style: textStyle20.copyWith(color: Colors.white)),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
