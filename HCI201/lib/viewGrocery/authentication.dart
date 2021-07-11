import 'package:flutter/material.dart';
import 'package:hci_201/viewGrocery/login.dart';
import 'package:hci_201/viewGrocery/register.dart';

class Authentication extends StatefulWidget {

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  bool isRegister = false;

  @override
  Widget build(BuildContext context) {


    void viewToggle() {
      setState(() {
        isRegister = !isRegister;
      });
    }

    if(isRegister == false) {
      return Login(viewToggle: viewToggle);
    }else {
      return Register(viewToggle: viewToggle);
    }

  }
}
