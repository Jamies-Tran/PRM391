import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hci_201/modelGrocery/user.dart';
import 'package:hci_201/serviceGrocery/api_service.dart';
import 'package:hci_201/serviceGrocery/database_service.dart';
import 'package:hci_201/shared/text_decoration.dart';

class Information extends StatefulWidget {
  final Users user;
  Information({this.user});

  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  final ApiService _api = ApiService();
  bool isNameEdit = false;
  bool isPhoneEdit = false;
  bool isAddressEdit = false;
  DBService _database;
  String name = "";
  int phone = 0;
  String address = "";
  bool _isChanged = false;

  @override
  Widget build(BuildContext context) {
    _database = DBService(uid: widget.user.uid);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 100),
      child: Column(
        children: [
          Text("Thông tin người dùng", style: textStyle30.copyWith(color: Colors.blueGrey)),
          SizedBox(height: 30),
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person, color: Colors.green, size: 20,),
              isNameEdit == false ? Text("${widget.user.username}", style: textStyle20) : Container(
                width: 200,
                child: TextFormField(
                  decoration: inputDecoration,
                  initialValue: '${widget.user.username}',
                  onChanged: (value) {
                    name = value;
                  },
                ),
              ),
              isNameEdit == false ? IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      isNameEdit = !isNameEdit;
                    });
                  }
              ) : Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.cancel, size: 30, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          isNameEdit = !isNameEdit;
                        });
                      }
                  ),
                  IconButton(
                      icon: Icon(Icons.check_circle, size: 30, color: Colors.green),
                      onPressed: () {
                        setState(() {
                          _database.updateUserInformation(name, null, null);
                          isNameEdit = !isNameEdit;
                          _isChanged = true;
                        });
                      }
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.mail, color: Colors.green, size: 20,),
              Text("${widget.user.email}", style: textStyle20)
            ],
          ),
          SizedBox(height: 20),
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.phone, color: Colors.green, size: 20,),
              isPhoneEdit == false ? Text(widget.user.phone == 0 ? "Vui lòng nhập số điện thoại"  : "${widget.user.phone}", style: textStyle20) : Container(
                width: 200,
                child: TextFormField(
                  decoration: inputDecoration,
                  initialValue: "${widget.user.phone}",
                  onChanged: (value) {
                    setState(() {
                      phone = int.parse(value);
                    });
                  },
                ),
              ),
              isPhoneEdit == false ? IconButton(icon: Icon(Icons.edit), onPressed: () {setState(() {
                isPhoneEdit = !isPhoneEdit;
              });}) : Row(children: [
                IconButton(icon: Icon(Icons.cancel, size: 30, color: Colors.red), onPressed: () { setState(() {
                  isPhoneEdit = !isPhoneEdit;
                }); }),
                IconButton(icon: Icon(Icons.check_circle, size: 30, color: Colors.green), onPressed: () { _database.updateUserInformation(null, phone, null);
                setState(() {
                  isPhoneEdit = !isPhoneEdit;
                  _isChanged = true;
                }); })
              ],),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_pin, color: Colors.green, size: 25,),
                  isAddressEdit == false ? Text(widget.user.address == null ? "vui lòng nhập địa chỉ" : "${widget.user.address}" , style: textStyle20) : Container(
                    width: 200,
                    child: TextFormField(
                      decoration: inputDecoration,
                      initialValue: '${widget.user.address}',
                      onChanged: (value) {
                        setState(() {
                          address = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              isAddressEdit == false ? IconButton(icon: Icon(Icons.edit), onPressed: () {setState(() {
                isAddressEdit = !isAddressEdit;
              });}) : Row(children: [
                IconButton(icon: Icon(Icons.cancel, size: 30, color: Colors.red), onPressed: () { setState(() {
                  isAddressEdit = !isAddressEdit;
                }); }),
                IconButton(icon: Icon(Icons.check_circle, size: 30, color: Colors.green), onPressed: () { _database.updateUserInformation(null, null, address);
                setState(() {
                  isAddressEdit = !isAddressEdit;
                  _isChanged = true;
                }); })
              ],),
            ],
          ),

          _isChanged == true ? Center(
            child: ButtonTheme(
                minWidth: MediaQuery.of(context).size.width * 0.5,
                child: RaisedButton(
                  color: Colors.green,
                  child: Text("Chấp nhận", style: textStyle20.copyWith(color: Colors.white)),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (dialogContex) {
                          return CupertinoAlertDialog(
                            title: Text("Thông báo", style: textStyle20.copyWith(color: Colors.black45)),
                            content: Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text("Xác nhận thay đổi?", style: textStyle20.copyWith(color: Colors.black45)),
                            ),
                            actions: [
                              CupertinoDialogAction(child: Text("Quay lại"), onPressed: () { Navigator.pop(context); },),
                              CupertinoDialogAction(child: Text("Xác nhận"), onPressed: () async {
                                Users _user;
                                await _database.userInformationByInpUid(widget.user.email).then((value) {
                                  _user = new Users(phone: value.data['phone'], address: value.data['address'], username: value.data['username'], id: value.data['id']);
                                });
                                await _api.updateAccount(_user, _user.id);
                                Navigator.pop(context);
                                },),
                            ],
                          );
                        },
                    );
                  },
                ),
            ),
          ) : SizedBox()

        ],
      ),
    );
  }
}
