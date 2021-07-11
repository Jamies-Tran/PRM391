import 'package:hci_201/shared/share_data.dart';

class Users {
  String uid;
  int id;
  String username;
  String password;
  int phone;
  String email;
  String address;
  USER_ROLE role;

  Users({this.uid, this.id, this.email, this.password, this.username, this.phone, this.address, this.role});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      role: json['role']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : this.id,
      'username' : this.username,
      'password' : this.password,
      'phone' : this.phone,
      'email' : this.email,
      'address' : this.address,
      'role' : this.role
    };
  }

}