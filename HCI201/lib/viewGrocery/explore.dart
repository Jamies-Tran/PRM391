import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hci_201/modelGrocery/product.dart';
import 'package:hci_201/modelGrocery/user.dart';
import 'package:hci_201/serviceGrocery/api_service.dart';
import 'package:hci_201/shared/text_decoration.dart';

class Explore extends StatefulWidget {

  final Users user;
  Explore({this.user});


  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {

  ApiService _api = ApiService();
  List<Product> _waterProductList = [];
  List<Product> _snackProductList = [];
  List<Product> _wineProductList = [];
  List<Product> _milkProductList = [];
  List<Product> _beerProductList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              //nuoc uong
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text("1 - Nước ngọt", style: textStyle25.copyWith(color: Colors.blueGrey)),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: FutureBuilder(
                  future: _api.getProductList(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      _waterProductList.addAll(snapshot.data.where((value) => value.category.compareTo("Water") == 0));
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _waterProductList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/product_info", arguments: {
                                'productId' : _waterProductList[index].id,
                                'user' : widget.user
                              });
                            },
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
                                        Text("Sản phẩm: " , style: textStyle20.copyWith(color: Colors.white)),
                                        Text("${_waterProductList[index].name}" , style: textStyle20.copyWith(color: Colors.white)),
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
                                        Text("Tồn kho: " , style: textStyle20.copyWith(color: Colors.white)),
                                        Text("${_waterProductList[index].stock}", style: textStyle20.copyWith(color: Colors.white)),
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

              // snack
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text("2 - Snack", style: textStyle25.copyWith(color: Colors.blueGrey)),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: FutureBuilder(
                  future: _api.getProductList(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      _snackProductList.addAll(snapshot.data.where((value) => value.category.compareTo("Snack") == 0));
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _snackProductList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/product_info", arguments: {
                                'productId' : _snackProductList[index].id,
                                'user' : widget.user
                              });
                            },
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
                                        Text("Sản phẩm: " , style: textStyle20.copyWith(color: Colors.white)),
                                        Text("${_snackProductList[index].name}" , style: textStyle20.copyWith(color: Colors.white)),
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
                                        Text("Tồn kho: " , style: textStyle20.copyWith(color: Colors.white)),
                                        Text("${_snackProductList[index].stock}", style: textStyle20.copyWith(color: Colors.white)),
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

              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text("3 - Rượu", style: textStyle25.copyWith(color: Colors.blueGrey)),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: FutureBuilder(
                  future: _api.getProductList(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      _wineProductList.addAll(snapshot.data.where((value) => value.category.compareTo("Wine") == 0));
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _wineProductList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/product_info", arguments: {
                                'productId' : _wineProductList[index].id,
                                'user' : widget.user
                              });
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 0.75,
                              padding: EdgeInsets.fromLTRB(0, 300, 0, 0),
                              margin: EdgeInsets.fromLTRB(0, 0, 25, 0),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("${_wineProductList[index].image}"),
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
                                        Text("Sản phẩm: " , style: textStyle20.copyWith(color: Colors.white)),
                                        Text("${_wineProductList[index].name}" , style: textStyle15.copyWith(color: Colors.white)),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Giá: " , style: textStyle20.copyWith(color: Colors.white)),
                                        Text("${_wineProductList[index].price~/1000}.000 VND", style: textStyle20.copyWith(color: Colors.white)),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Tồn kho: " , style: textStyle20.copyWith(color: Colors.white)),
                                        Text("${_wineProductList[index].stock}", style: textStyle20.copyWith(color: Colors.white)),
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

              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text("4 - Sữa Nestle", style: textStyle25.copyWith(color: Colors.blueGrey)),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: FutureBuilder(
                  future: _api.getProductList(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      _milkProductList.addAll(snapshot.data.where((value) => value.category.compareTo("Milk") == 0));
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _milkProductList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/product_info", arguments: {
                                'productId' : _milkProductList[index].id,
                                'user' : widget.user
                              });
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 0.75,
                              padding: EdgeInsets.fromLTRB(0, 300, 0, 0),
                              margin: EdgeInsets.fromLTRB(0, 0, 25, 0),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("${_milkProductList[index].image}"),
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
                                        Text("Sản phẩm: " , style: textStyle20.copyWith(color: Colors.white)),
                                        Text("${_milkProductList[index].name}" , style: textStyle20.copyWith(color: Colors.white)),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Giá: " , style: textStyle20.copyWith(color: Colors.white)),
                                        Text("${_milkProductList[index].price~/1000}.000 VND", style: textStyle20.copyWith(color: Colors.white)),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Tồn kho: " , style: textStyle20.copyWith(color: Colors.white)),
                                        Text("${_milkProductList[index].stock}", style: textStyle20.copyWith(color: Colors.white)),
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
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text("5 - Bia", style: textStyle25.copyWith(color: Colors.blueGrey)),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: FutureBuilder(
                  future: _api.getProductList(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      _beerProductList.addAll(snapshot.data.where((value) => value.category.compareTo("Beer") == 0));
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _beerProductList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/product_info", arguments: {
                                'productId' : _beerProductList[index].id,
                                'user' : widget.user
                              });
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 0.75,
                              padding: EdgeInsets.fromLTRB(0, 300, 0, 0),
                              margin: EdgeInsets.fromLTRB(0, 0, 25, 0),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("${_beerProductList[index].image}"),
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
                                        Text("Sản phẩm: " , style: textStyle20.copyWith(color: Colors.white)),
                                        Text("${_beerProductList[index].name}" , style: textStyle20.copyWith(color: Colors.white)),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Giá: " , style: textStyle20.copyWith(color: Colors.white)),
                                        Text("${_beerProductList[index].price~/1000}.000 VND", style: textStyle20.copyWith(color: Colors.white)),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Tồn kho: " , style: textStyle20.copyWith(color: Colors.white)),
                                        Text("${_beerProductList[index].stock}", style: textStyle20.copyWith(color: Colors.white)),
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

            ],
          ),
        ),
      ),
    );
  }
}
