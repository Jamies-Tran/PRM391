
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hci_201/modelGrocery/user.dart';
import 'package:hci_201/serviceGrocery/auth_service.dart';
import 'package:hci_201/serviceGrocery/database_service.dart';
import 'package:hci_201/shared/text_decoration.dart';
import 'package:hci_201/viewGrocery/Information.dart';
import 'package:hci_201/viewGrocery/explore.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {

  final String userUid;

  MainScreen({this.userUid});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  AuthService _auth = AuthService();

  DBService _database;

  int _currentIndex = 0;

  Users _user;

  @override
  Widget build(BuildContext context) {
    _database = DBService(uid: widget.userUid);
    // final _userInfo = _database.userInformation2;

    // user = Users(username: _userInfo.data['username'], email: _userInfo.data['email'], phone: int.parse(_userInfo.data['phone']), address: _userInfo.data['address'], uid: _userInfo.documentID);

    // for(var doc in _userInfo.data['username']) {
    //   user = Users(username: doc.data['username'], email: doc.data['email'], phone: int.parse(doc.data['phone']), address: doc.data['address'], uid: doc.documentID);
    // }
    List<Widget> widgetList = [
      FutureBuilder(
          future: _database.userInformation3(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              _user = Users(uid: snapshot.data.documentID, username: snapshot.data['username'], email: snapshot.data['email'], phone: int.parse(snapshot.data['phone']), address: snapshot.data['address']);
              return Explore(user: _user);
            }else {
              return SpinKitChasingDots(color: Colors.green);
            }
          },
      ),
      FutureBuilder(
        future: _database.userInformation3(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            _user = Users(uid: snapshot.data.documentID, username: snapshot.data['username'], email: snapshot.data['email'], phone: int.parse(snapshot.data['phone']), address: snapshot.data['address']);
            return Information(user: _user);
          }else {
            return SpinKitChasingDots(color: Colors.green);
          }
        },
      ),

    ];
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Khám phá',
              activeIcon: Icon(Icons.shopping_cart, color: Colors.green)
          ),
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
