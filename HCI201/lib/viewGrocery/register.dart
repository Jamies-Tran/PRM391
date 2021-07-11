import 'package:flutter/material.dart';
import 'package:hci_201/serviceGrocery/auth_service.dart';
import 'package:hci_201/shared/loading.dart';
import 'package:hci_201/shared/share_data.dart';
import 'package:hci_201/shared/text_decoration.dart';

class Register extends StatefulWidget {

  final Function viewToggle;

  Register({this.viewToggle});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  GlobalKey<FormState> _key = GlobalKey();
  AuthService _auth = AuthService();
  String email = "";
  String password = "";
  String username = "";
  String phone = "";
  String address = "";
  USER_ROLE role = USER_ROLE.GROCERY;
  String error = "";
  bool isLoading = false;

  void validForm() async {
    bool isValidData = _key.currentState.validate();
    if(isValidData == true) {
      setState(() {
        isLoading = true;
      });
      dynamic result = await _auth.registerWithEmailAndPassword(email, password, username, phone, address, role);
      if(result == null) {
        setState(() {
          error = "Email đăng nhập không hợp lệ.";
          isLoading = false;
        });
      }else {
        isLoading = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text(
            "Đăng kí",
            style: textStyle20.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.0)
        ),
        actions: [
          RaisedButton.icon(
            onPressed: widget.viewToggle,
            icon: Icon(Icons.person, size: 15),
            label: Text(
                "Đăng nhập",
                style: textStyle15
            ),
            color: Colors.green,
          ),
        ],
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
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
                    decoration: inputDecoration.copyWith(hintText: "mật khẩu", hintStyle: textStyle15),
                    validator: (value) => value.isEmpty ? "Mời bạn nhập password" : null,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    }
                ),
                SizedBox(height: 20),
                TextFormField(
                    decoration: inputDecoration.copyWith(hintText: "Username", hintStyle: textStyle15),
                    validator: (value) => value.isEmpty ? "Mời bạn nhập username" : null,
                    onChanged: (value) {
                      setState(() {
                        username = value;
                      });
                    }
                ),
                SizedBox(height: 20),
                TextFormField(
                    decoration: inputDecoration.copyWith(hintText: "Số điện thoại", hintStyle: textStyle15),
                    keyboardType: TextInputType.phone,
                    validator: (value) => value.isEmpty ? "Mời bạn nhập số điện thoại" : null,
                    onChanged: (value) {
                      setState(() {
                        phone = value;
                      });
                    }
                ),
                SizedBox(height: 20),
                TextFormField(
                    decoration: inputDecoration.copyWith(hintText: "Địa chỉ", hintStyle: textStyle15),
                    validator: (value) => value.isEmpty ? "Mời bạn nhập Địa chỉ" : null,
                    onChanged: (value) {
                      setState(() {
                        address = value;
                      });
                    }
                ),
                SizedBox(height: 20),
                RaisedButton(
                  onPressed: validForm,
                  color: Colors.green,
                  child: Text(
                      "Đăng kí",
                      style: textStyle15,
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
      ),
    );
  }
}
