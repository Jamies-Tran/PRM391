import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {

  final CollectionReference _userCollection = Firestore.instance.collection("users");

  final String uid;

  DBService({this.uid});

  Future registerUserInformation(String email, String username,  String phone, String address, String role) async {
    return await _userCollection.document(uid).setData({
      'email' : email,
      'username' : username,
      'phone' : phone,
      'address' : address,
      'role' : role
    });
  }

  Future updateUserInformation(String username,  String phone, String address) async {
    if(username != null && phone == null && address == null) {
      return await _userCollection.document(uid).updateData({'username' : username});
    }else if(username == null && phone != null && address == null) {
      return await _userCollection.document(uid).updateData({'phone' : phone});
    }else if(username == null && phone == null && address != null) {
      return await _userCollection.document(uid).updateData({'address' : address});
    }
  }

  Stream<QuerySnapshot> get userInformation {
    return _userCollection.snapshots();
  }

  Future<DocumentSnapshot> userInformation3() {
    return _userCollection.document(uid).get();
  }

}