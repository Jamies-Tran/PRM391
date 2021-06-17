import 'package:hci_201/model/account.dart';
import 'package:hci_201/model/category.dart';
import 'package:hci_201/model/chef.dart';
import 'package:hci_201/model/get_enum.dart';

class Consumer extends Account {
  String addr;
  String email;
  String errMsg;
  String name;
  String password;
  String phone;
  Account_Type role;
  String avatar;
  List<Category> cateList = [];
  List<Chef> chefFollowed = [];
  RegExp reg;


  Consumer({this.email, this.password, this.name, this.phone, this.addr, this.role})
      : super(email: email, password: password, name: name, phone: phone, addr: addr, role: role);



  // implement super class method (valid data) - start

  @override
  bool validEmail() {
    reg = RegExp(r"^([a-zA-Z0-9]+)@([a-z]+)\.([a-z]+)$",
        multiLine: false, caseSensitive: false);
    if (!reg.hasMatch(email) || email.isEmpty || email == "") {
      errMsg = "Invalid email(Ex: mealguru@gmail.com)";
      return false;
    }
    return true;
  }

  @override
  bool validName() {
    reg = RegExp(r"^([a-zA-Z]+)([0-9]+)$",
        multiLine: false, caseSensitive: false);
    if (!reg.hasMatch(name) || name.isEmpty || name == "") {
      errMsg = "Invalid username(Ex: jamies123).";
      return false;
    }
    if (name.length < 5 || name.length > 10) {
      errMsg = "Username length between 5 and 10.";
      return false;
    }
    return true;
  }

  @override
  bool validPassword() {
    reg = RegExp(r"^([a-zA-Z]+)([0-9]+)$",
        multiLine: false, caseSensitive: false);
    if (!reg.hasMatch(password) || password.isEmpty || password == "") {
      errMsg = "invalid password(Ex: mealguru123).";
      return false;
    }
    if (password.length < 5 || password.length > 10) {
      errMsg = "Password length between 5 and 10.";
      return false;
    }
    return true;
  }

  @override
  bool validPhone() {
    reg = RegExp(r"^([0-9]+)$", multiLine: false, caseSensitive: false);
    if (!reg.hasMatch(phone) ||
        phone.isEmpty ||
        phone == "" ||
        phone.length < 10 ||
        phone.length > 10) {
      errMsg = "invalid phone number(Ex: 0981874736).";
      return false;
    }
    return true;
  }

  @override
  bool validAddr() {
    reg = RegExp(r"^([a-zA-Z]+)([0-9]+)$",
        multiLine: false, caseSensitive: false);
    if (!reg.hasMatch(addr) || addr.isEmpty || addr == "") {
      errMsg = "Invalid address";
      return false;
    }
    return true;
  }

  // implement super class method (valid data) - end

  void addCategory(Category _cate) {
    if(_cate.getSelectedChoice() == true) {
      this.cateList.add(_cate);
      print('has added ${_cate.getTitle()}');
      print('${this.cateList.length}');
    }else {
      if(this.cateList.contains(_cate)) {
        this.cateList.remove(_cate);
        print('has remove ${_cate.getTitle()} - ${this.cateList.remove(_cate)}');
        print('${this.cateList.length}');
      }
    }
  }

  void addOrRemoveFollowChef(Chef _chef, bool isAdd) {
    if(isAdd == true) {
      this.chefFollowed.add(_chef);
      print("add");
      print("size : ${this.chefFollowed.length}");
    }else {
      if(this.chefFollowed.contains(_chef)) {
        this.chefFollowed.remove(_chef);
      }
      print("remove - ${_chef.name}");
      print("size : ${this.chefFollowed.length}");
    }
  }
}
