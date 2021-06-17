import 'package:flutter/material.dart';
import 'package:hci_201/model/account.dart';
import 'package:hci_201/model/category.dart';
import 'package:hci_201/model/consumer.dart';
import 'package:hci_201/model/get_enum.dart';
import 'package:hci_201/widgets/appbar.dart';


class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController nameController;
  TextEditingController phoneController;
  TextEditingController addrController;

  Consumer _acc = Consumer(role: Account_Type.values[0]);

  String email;
  String password;
  String name;
  String addr;
  String phone;
  int flag = 1;


  GlobalKey<FormState> _key = GlobalKey();

  void _saveForm() {
    bool isValidate = _key.currentState.validate();
    if (isValidate == true) {
      Navigator.pushNamed(context, "/loading", arguments: {
        'acc' : _acc,
        'flag' : flag
      });
    }
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    addrController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    addrController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(context, "Register"),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/logintheme.png"),
                    fit: BoxFit.cover
                )
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Form(
                  key: _key,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 30),

                          child: Text(
                            'Please fill in a few detail below.',
                            style: TextStyle(
                                fontSize: 40,
                                fontFamily: 'koho',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0
                            ),
                          ),
                        ),

                        TextFormField(
                          controller: emailController,
                          validator: (String value) {
                            setState(() {
                              email = value;
                            });
                            _acc.email = email;
                            if(_acc.validEmail() == false) {
                              return _acc.errMsg;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'koho',
                                  letterSpacing: 2.0
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2, color: Colors
                                      .pinkAccent),
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      15))
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2, color: Colors
                                      .black),
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      15))
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2 ,color: Colors.red[900]),
                                borderRadius: BorderRadius.all(Radius.circular(15))
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2, color: Colors.red[900]),
                                borderRadius: BorderRadius.all(Radius.circular(15))
                              ),
                              filled: true,
                              fillColor: Colors.white
                          ),
                        ),

                        SizedBox(height: 20),

                        TextFormField(
                          controller: passwordController,
                          validator: (String value) {
                            setState(() {
                              password = value;
                            });
                            _acc.password = password;
                            if(_acc.validPassword() == false) {
                              return _acc.errMsg;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'koho',
                                  letterSpacing: 2.0
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2, color: Colors
                                      .red),
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      15))
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2, color: Colors
                                      .black),
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      15))
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2, color: Colors.red[900]),
                                borderRadius: BorderRadius.circular(15)
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2, color: Colors.red[900]),
                                  borderRadius: BorderRadius.all(Radius.circular(15))
                              ),
                              filled: true,
                              fillColor: Colors.white
                          ),
                        ),

                        SizedBox(height: 20),

                        TextFormField(
                          controller: nameController,
                          validator: (String value) {
                            setState(() {
                              name = value;
                            });
                            _acc.name = name;
                            if(_acc.validName() == false) {
                              return _acc.errMsg;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Name",
                              labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'koho',
                                  letterSpacing: 2.0
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2, color: Colors
                                      .red),
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      15))
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2, color: Colors
                                      .black),
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      15))
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2, color: Colors.red[900]),
                                borderRadius: BorderRadius.circular(15)
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2, color: Colors.red[900]),
                                  borderRadius: BorderRadius.all(Radius.circular(15))
                              ),
                              filled: true,
                              fillColor: Colors.white
                          ),
                        ),

                        SizedBox(height: 20),

                        TextFormField(
                          controller: addrController,
                          validator: (String value) {
                            setState(() {
                              addr = value;
                            });
                            _acc.addr = addr;
                            if(_acc.validAddr() == false) {
                              return _acc.errMsg;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Address",
                              labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'koho',
                                  letterSpacing: 2.0
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2, color: Colors
                                      .red),
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      15))
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2, color: Colors
                                      .black),
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      15))
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2, color: Colors
                                      .red[900]),
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      15))
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2, color: Colors.red[900]),
                                borderRadius: BorderRadius.circular(15)
                              ),
                              filled: true,
                              fillColor: Colors.white
                          ),
                        ),

                        SizedBox(height: 20),

                        TextFormField(
                          controller: phoneController,
                          validator: (String value) {
                            setState(() {
                              phone = value;
                            });
                            _acc.phone = phone;
                            if(_acc.validPhone() == false) {
                              return _acc.errMsg;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Phone number",
                              labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'koho',
                                  letterSpacing: 2.0
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2, color: Colors
                                      .red),
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      15))
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2, color: Colors
                                      .black),
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      15))
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2, color: Colors.red[900]),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2, color: Colors.red[900]),
                                  borderRadius: BorderRadius.all(Radius.circular(15))
                              ),
                              filled: true,
                              fillColor: Colors.white
                          ),
                        ),

                        SizedBox(height: 100),

                        ButtonTheme(
                          minWidth: 400,
                          height: 50,
                          buttonColor: Colors.black,
                          child: RaisedButton(
                            onPressed: _saveForm,
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'koho',
                                  letterSpacing: 2.0,
                                  color: Colors.white
                              ),
                            ),
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}