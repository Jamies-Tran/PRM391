import 'package:flutter/material.dart';
import 'package:hci_201/modelGrocery/user.dart';
import 'package:hci_201/serviceGrocery/database_service.dart';
import 'package:hci_201/shared/text_decoration.dart';

class Information extends StatefulWidget {
  final Users user;
  Information({this.user});

  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  bool isNameEdit = false;
  bool isPhoneEdit = false;
  bool isAddressEdit = false;
  DBService _database;
  String name = "";
  String phone = "";
  String address = "";

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
              isNameEdit == false ? Text("${widget.user.username}", style: textStyle25) : Container(
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
                        });
                      }
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.mail, color: Colors.green, size: 25,),
              Text("${widget.user.email}", style: textStyle25)
            ],
          ),
          SizedBox(height: 30),
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.phone, color: Colors.green, size: 25,),
              isPhoneEdit == false ? Text("${widget.user.phone}", style: textStyle25) : Container(
                width: 200,
                child: TextFormField(
                  decoration: inputDecoration,
                  initialValue: '${widget.user.phone}',
                  onChanged: (value) {
                    setState(() {
                      phone = value;
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
                }); })
              ],),
            ],
          ),
          SizedBox(height: 30),
          Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_pin, color: Colors.green, size: 25,),
                  isAddressEdit == false ? Text("${widget.user.address}", style: textStyle20) : Container(
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
                }); })
              ],),
            ],
          )
        ],
      ),
    );
  }
}
