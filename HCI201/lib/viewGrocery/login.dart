import 'package:flutter/material.dart';
import 'package:hci_201/serviceGrocery/auth_service.dart';
import 'package:hci_201/shared/loading.dart';
import 'package:hci_201/shared/share_data.dart';
import 'package:hci_201/shared/text_decoration.dart';

class Login extends StatefulWidget {

  final Function viewToggle;

  Login({this.viewToggle});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  GlobalKey<FormState> _key = GlobalKey();
  AuthService _auth = AuthService();
  String email = "";
  String password = "";
  String error = "";
  bool isLoading = false;

  void validForm() async {
    bool isValidData = _key.currentState.validate();
    if(isValidData == true) {
      setState(() {
        isLoading = true;
      });
      dynamic result = await _auth.loginWithEmailAndPassword(email, password);
      if(result == null) {
        setState(() {
          error = "Email đăng nhập không hợp lệ.";
          isLoading = false;
        });
      }else {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text(
            "Đăng nhập",
            style: textStyle20.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.0)
        ),
        actions: [
          RaisedButton.icon(
              onPressed: widget.viewToggle,
              icon: Icon(Icons.accessibility_new),
              label: Text(
                  "Đăng kí",
                  style: textStyle15
              ),
              color: Colors.green,
          ),
        ],
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                decoration: inputDecoration.copyWith(hintText: "Email", hintStyle: textStyle15),
                validator: (value) => value.isEmpty ? "Mời bạn nhập email" : null,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                }
              ),
              SizedBox(height: 20),
              TextFormField(
                  decoration: inputDecoration.copyWith(hintText: "Password", hintStyle: textStyle15),
                  obscureText: true,
                  validator: (value) => value.isEmpty ? "Mời bạn nhập password" : null,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  }
              ),
              SizedBox(height: 20),
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width * 0.5,
                height: 50,
                child: RaisedButton(
                    onPressed: validForm,
                    color: Colors.green,
                    child: Text(
                        "Đăng nhập",
                        style: textStyle15.copyWith(color: Colors.white),
                    ),
                ),
              ),
              SizedBox(height: 20),
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width * 0.5,
                height: 50,
                child: RaisedButton(
                  onPressed: () async {
                    await _auth.signingWithGoogle(USER_ROLE.GROCERY);
                  },
                  color: Colors.green,
                  child: Text(
                    "Đăng nhập bằng google",
                    style: textStyle15.copyWith(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "$error",
                style: textStyle15.copyWith(color: Colors.red),
              )
            ],
          ),
        ),
      ),
    );
  }
}
