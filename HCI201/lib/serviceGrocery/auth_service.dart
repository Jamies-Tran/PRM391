import 'package:firebase_auth/firebase_auth.dart';
import 'package:hci_201/modelGrocery/user.dart';
import 'package:hci_201/serviceGrocery/api_service.dart';
import 'package:hci_201/serviceGrocery/database_service.dart';
import 'package:hci_201/shared/share_data.dart';
import 'package:google_sign_in/google_sign_in.dart';
class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ApiService _api = ApiService();
  DBService _database;

  // tạo custom user
  Users _getUserFromFirebase(FirebaseUser user) {
    return user != null ? Users(uid: user.email) : null;
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
  Future registerWithEmailAndPassword(String email, String password, String username, int phone, String address, USER_ROLE role) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      _database = DBService(uid: user.email);
      _database.registerUserInformation(0, email, username, password ,phone, address,role.toString());
      return _getUserFromFirebase(user);
    }catch(e) {
      return null;
    }
  }

  Future signingWithGoogle(USER_ROLE role) async {
    try {
      final GoogleSignInAccount _account = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication _googleAuth = await _account.authentication;
      final AuthCredential _credential = GoogleAuthProvider.getCredential(idToken: _googleAuth.idToken, accessToken: _googleAuth.idToken);
      _database = DBService(uid: _account.email);
      _database.registerUserInformation(0, _account.email, _account.displayName, null, 0, null, role.toString());
      return _auth.signInWithCredential(_credential);
    }catch(e) {
      print("Can't login to google");
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