import 'package:flutter/material.dart';
import 'package:hci_201/modelGrocery/user.dart';
import 'package:hci_201/serviceGrocery/auth_service.dart';
import 'package:hci_201/viewGrocery/booking.dart';
import 'package:hci_201/viewGrocery/edit_order.dart';
import 'package:hci_201/viewGrocery/product_info.dart';
import 'package:hci_201/wrapper.dart';
import 'package:provider/provider.dart';

import 'package:hci_201/viewGrocery/sales.dart';

import 'viewGrocery/explore.dart';
import 'viewGrocery/explore.dart';
import 'viewGrocery/main_screen.dart';
import 'wrapper.dart';
import 'wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    return StreamProvider<Users>.value(
      value: _auth.user,
      child: MaterialApp(
        home: Wrapper(),
        routes: {
          '/booking' : (context) => Booking(),
          '/product_info' : (context) => ProductInfo(),
          '/main' : (context) => Wrapper(),
          '/edit_order' : (context) => EditOrder(),
          //'/sales' : (context) => SalesReportScreen(),
        }
      ),
    );
  }
}


