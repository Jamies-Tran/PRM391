// đây là abstract class của 2 class là chef và consumer
import 'package:hci_201/model/category.dart';
import 'package:hci_201/model/consumer.dart';
import 'package:hci_201/model/get_enum.dart';

abstract class Account {
  String email;
  String password;
  String name;
  String phone;
  String addr;
  String errMsg;
  Account_Type role;
  String avatar;

  Account({this.email, this.password, this.name, this.phone, this.addr, this.role});

  bool validEmail();

  bool validPassword();

  bool validName();

  bool validPhone();

  bool validAddr();



  // getter_setter_start

  // String getEmail();
  //
  // void setEmail(String email);
  //
  // String getPassword();
  //
  // void setPassword(String password);
  //
  // String getName();
  //
  // void setName(String name);
  //
  // String getPhone();
  //
  // void setPhone(String phone);
  //
  // String getAddr();
  //
  // void setAddr(String addr);
  //
  // List<Category> getCateList();
  //
  // void setCateList(List<Category> cateList);
  //
  // Account_Type getRole();
  //
  // int getPrice();
  //
  // void setPrice(int price);
  //
  // double getStar();
  //
  // void setStar(double star);
  //
  // String getAvatar();
  //
  // void setAvatar(String avatar);
  //
  // // getter_setter_end
  //
  // // validation_start
  //
  // bool validEmail();
  //
  // bool validPassword();
  //
  // bool validName();
  //
  // bool validPhone();
  //
  // bool validAddr();
  //
  // // validation_end
  //
  // void addCategory(Category _cate);

}
