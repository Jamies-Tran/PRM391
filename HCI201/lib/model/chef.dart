import 'package:hci_201/model/account.dart';
import 'package:hci_201/model/category.dart';
import 'package:hci_201/model/chef_food.dart';
import 'package:hci_201/model/get_enum.dart';

class Chef extends Account{
  String addr;
  String email;
  String errMsg;
  String name;
  String password;
  String phone;
  String avatar;
  Account_Type role;
  List<Category> cateList = [];
  List<ChefFood> chefFood = [];
  double star;
  int price;
  bool isThereFollower = false;
  RegExp reg;

  Chef({this.email, this.password, this.name, this.phone, this.addr, this.star = 0, this.avatar, this.role, this.price}) :
        super(email: email, password: password, name: name, phone: phone, addr: addr, role: role);

  // implement super class method (valid datata) - start
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

  @override
  bool validEmail() {
    reg = RegExp(r"^([a-zA-Z0-9]+)@([a-z]+)\.([a-z]+)$",
        multiLine: false, caseSensitive: false);
    if (!reg.hasMatch(email) || email.isEmpty || email == "") {
      errMsg = "Invalid email";
      return false;
    }
    return true;
  }

  @override
  bool validName() {
    reg = RegExp(r"^([a-zA-Z]+)([0-9]+)$",
        multiLine: false, caseSensitive: false);
    if (!reg.hasMatch(name) || name.isEmpty || name == "") {
      errMsg = "Invalid email(Ex: mealguru123@gmail.com).";
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
    reg = RegExp(r"^[0-9]$", multiLine: false, caseSensitive: false);
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

  // implement super class method (valid datata) - end

  bool validPrice() {
    reg = RegExp(r"^[0-9]$", multiLine: false, caseSensitive: false);
    if(!reg.hasMatch(price.toString()) || price.toString().length < 4) {
      errMsg = "Invalid price(Ex: 5000)";
      return false;
    }
    return true;
  }

  // valid-data-end

  bool getIsFollowed() {
    return this.isThereFollower;
  }

  void setIsFollowed(bool isFollowed) {
    this.isThereFollower = isFollowed;
  }
}
