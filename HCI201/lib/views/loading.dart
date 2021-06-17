import 'package:flutter/material.dart';
import 'package:hci_201/model/account.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hci_201/model/chef.dart';
import 'package:hci_201/model/consumer.dart';
import 'package:hci_201/model/get_enum.dart';
import 'package:hci_201/service/iservice.dart';
import 'package:hci_201/service/serviceimpl.dart';

class Loading extends StatefulWidget {
  const Loading({Key key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  Account _acc;
  Consumer _guest;
  Chef _partner;
  String email;
  String password;
  int flag;
  String err;
  IService service = ServiceImpl();
  bool isLoginSuccess;
  
  @override
  build(BuildContext context)  {
    Map data = ModalRoute.of(context).settings.arguments;
    flag = data['flag'];
    if(flag == 0) {
      email = data['email'];
      password = data['password'];
      isLoginSuccess = service.loginFunction(email, password, context);
      if(isLoginSuccess == false) {
        err = "Wrong email or password";
        service.errChangeScreen(err, context);
      }
    }else {
      _acc = data["acc"];
      service.regChangeScreen(_acc, context);
    }
    return Container(
      child: SpinKitSquareCircle(
        color: Colors.white,
      ),
      color: Colors.red,
    );
  }
}
