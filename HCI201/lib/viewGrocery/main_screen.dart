
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hci_201/modelGrocery/user.dart';
import 'package:hci_201/modelGrocery/product.dart';
import 'package:hci_201/modelGrocery/sales_report.dart';
import 'package:hci_201/serviceGrocery/auth_service.dart';
import 'package:hci_201/serviceGrocery/database_service.dart';
import 'package:hci_201/shared/text_decoration.dart';
import 'package:hci_201/viewGrocery/Information.dart';
import 'package:hci_201/viewGrocery/explore.dart';
import 'package:hci_201/viewGrocery/view_order.dart';
import 'package:provider/provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hci_201/serviceGrocery/api_service.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {

  final Users user;
  MainScreen({this.user});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  AuthService _auth = AuthService();

  DBService _database;

  int _currentIndex = 0;

  Users _user;

  String barcode= "Unknown";
  ApiService _api = ApiService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _database = DBService(uid: widget.user.uid);


    String username= "unknown";
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    // final _userInfo = _database.userInformation2;

    // user = Users(username: _userInfo.data['username'], email: _userInfo.data['email'], phone: int.parse(_userInfo.data['phone']), address: _userInfo.data['address'], uid: _userInfo.documentID);

    // for(var doc in _userInfo.data['username']) {
    //   user = Users(username: doc.data['username'], email: doc.data['email'], phone: int.parse(doc.data['phone']), address: doc.data['address'], uid: doc.documentID);
    // }
    List<Widget> widgetList = [
      FutureBuilder(
          future: _database.userInformationByUid(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              _user = Users(uid: snapshot.data.documentID, username: snapshot.data['username'], email: snapshot.data['email'], phone: snapshot.data['phone'], address: snapshot.data['address']);
              return Explore(user: _user);
            }else {
              return SpinKitChasingDots(color: Colors.green);
            }
          },
      ),
      FutureBuilder(
        future: _database.userInformationByUid(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            username= snapshot.data['username'];
            _user = Users(uid: snapshot.data.documentID, username: snapshot.data['username'], email: snapshot.data['email'], phone: snapshot.data['phone'], address: snapshot.data['address'], id: snapshot.data['id']);
            return ViewOrder(user: _user);
          }else {
            return SpinKitChasingDots(color: Colors.green);
          }
        },
      ),
      FutureBuilder(
        future: _database.userInformationByUid(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            _user = Users(uid: snapshot.data.documentID, username: snapshot.data['username'], email: snapshot.data['email'], phone: snapshot.data['phone'], address: snapshot.data['address']);
            return Information(user: _user);
          }else {
            return SpinKitChasingDots(color: Colors.green);
          }
        },
      ),

    ];

    Future<void> scanBarcode() async {
      try {
        final barcode = await FlutterBarcodeScanner.scanBarcode(
            "#ff6666",
            "Cancel",
            true,
            ScanMode.BARCODE);

        if (!mounted) return;

        setState(() {
          this.barcode = barcode;
        });
      } on PlatformException {
        barcode= 'Failed to get platform version!';
      }
    }

    // if(_currentIndex== 1) {
    //   scanBarcode();
    //   Product product= _api.getProductByBarcode(barcode);
    //   SalesReport srByBarcode= _api.getsalesReportByBarcode(barcode);
    //   int quantity;
    //   if(srByBarcode!= null) {
    //     quantity= srByBarcode.qty + 1;
    //   } else {
    //     quantity= 1;
    //   }
    //   int productPrice= product.price;
    //   int amount= productPrice * quantity;
    //
    //   SalesReport sr= new SalesReport(
    //     date: formattedDate,
    //     username: username,
    //     category: product.category,
    //     prodCode: product.code,
    //     prodName: product.name,
    //     price: productPrice,
    //     qty: quantity,
    //     amount: amount,
    //     image: product.image,
    //   );
    //   _api.addSalesReportRecord(sr);
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Xin chào",
          style: textStyle15,
        ),
        actions: [
          RaisedButton.icon(
              icon: Icon(Icons.logout, size: 15),
              onPressed: () async {
                await _auth.logOut();
              },
              label: Text("Đăng xuất", style: textStyle15),
              color: Colors.green,
          )
        ],
        backgroundColor: Colors.green,
      ),
      // body: Center(child: Column(children: <Widget>[
      //   Container(
      //     child: OutlineButton(
      //       child: Text("Doanh thu hôm nay", style: TextStyle(fontSize: 20.0),),
      //       onPressed: () {
      //         Navigator.pushNamed(context, "/sales", arguments: {
      //           'date' : formattedDate
      //         });
      //       },
      //     ),
      //   ),
      // ])),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Khám phá',
              activeIcon: Icon(Icons.category, color: Colors.green)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Đơn hàng',
              activeIcon: Icon(Icons.shopping_cart, color: Colors.green)
          ),
          // BottomNavigationBarItem(
          //     icon: FaIcon(FontAwesomeIcons.barcode),
          //     activeIcon: FaIcon(FontAwesomeIcons.barcode, color: Colors.green)
          // ),
          BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'Thông tin',
              activeIcon: Icon(Icons.info, color: Colors.green)
          ),
        ],
      ),
      body: widgetList[_currentIndex],
    );
  }
}
