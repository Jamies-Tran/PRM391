import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hci_201/modelGrocery/user.dart';
import 'package:hci_201/serviceGrocery/database_service.dart';
import 'package:hci_201/viewGrocery/authentication.dart';
import 'package:hci_201/viewGrocery/main_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Users>(context);

    if(user == null) {
      return Authentication();
    }else  {
      // return StreamProvider<DocumentSnapshot>.value(
      //     value: DBService(uid: user.uid).userInformation2,
      //     child: MainScreen(),
      // );
      return MainScreen(userUid: user.uid);
    }
  }
}
