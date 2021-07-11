import 'package:firebase_auth/firebase_auth.dart';
import 'package:hci_201/modelGrocery/user.dart';
import 'package:hci_201/serviceGrocery/database_service.dart';
import 'package:hci_201/shared/share_data.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  DBService _database;

  // tạo custom user
  Users _getUserFromFirebase(FirebaseUser user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  // Stream event thông báo thay đổi authen
  Stream<Users> get user {
    return _auth.onAuthStateChanged.map((user) => _getUserFromFirebase(user));
  }

  // log in bằng email và password
  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _getUserFromFirebase(user);
    }catch(e) {
      return null;
    }
  }

  // register bằng email và password
  Future registerWithEmailAndPassword(String email, String password, String username, String phone, String address, USER_ROLE role) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      _database = DBService(uid: user.uid);
      _database.registerUserInformation(email, username, phone, address, role.toString());
      return _getUserFromFirebase(user);
    }catch(e) {
      return null;
    }
  }

  // log out
  Future logOut() async {
    try{
      return await _auth.signOut();
    }catch(e) {
      return null;
    }
  }

}