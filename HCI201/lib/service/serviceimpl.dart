import 'package:flutter/cupertino.dart';
import 'package:hci_201/model/account.dart';
import 'package:hci_201/model/chef.dart';
import 'package:hci_201/model/chef_food.dart';
import 'package:hci_201/model/consumer.dart';
import 'package:hci_201/model/food.dart';
import 'package:hci_201/model/get_enum.dart';
import 'package:hci_201/service/iservice.dart';

class ServiceImpl implements IService {

  @override
  Food getFoodByID(int id) {
    for(Food x in getFoodList()) {
      if(x.id == id) {
        return x;
      }
    }
    return null;
  }

  @override
  Food getFoodByName(String name) {
    RegExp regex = RegExp(name, multiLine: false, caseSensitive: true);
    for(Food x in getFoodList()) {
      if(regex.hasMatch(x.name)) {
        return x;
      }
    }
    return null;
  }

  @override
  Future<void> errChangeScreen(String err, BuildContext context) async {
    await Future.delayed(Duration(seconds: 5), () {
      Navigator.pushNamed(context, "/err", arguments: {
        'err' : err
      });
    });
  }


  // gop hai list consumer va chef de kiem tra login
  @override
  List<Account> getAccountList() {
    List<Account> _list = [];
    _list.addAll(getConsumerList());
    _list.addAll(getChefList());
    return _list;
  }

  @override
  bool loginFunction(String email, String password, BuildContext context) {
    List<Account> accList = getAccountList();
    // lap qua account list
    for(int i = 0; i < accList.length; i++) {
      // tim account trung email va password, neu co thi check role
      if(accList[i].email.compareTo(email) == 0 && accList[i].password.compareTo(password) == 0) {
        // check neu role new account la consumer
        if(accList[i].role == Account_Type.values[0]) {
          Consumer _con = getConsumerByEmail(accList[i].email);
          // chuyen mang hinh sang consumer view
          loginChangeScreen(_con, context);
          return true;
          // neu account la chef
        }else if(accList[i].role == Account_Type.values[1]) {
          Chef _chef = getChefByEmail(accList[i].email);
          // chuyen mang hinh sang chef view
          loginChangeScreen(_chef, context);
          return true;
        }
      }
    }
    return false;
  }

  @override
  Consumer getConsumerByEmail(String email) {
    List<Consumer> _list = getConsumerList();
    for(Consumer _con in _list) {
      if(_con.email.compareTo(email) == 0) {
        return _con;
      }
    }
    return null;
  }

  @override
  Chef getChefByEmail(String email) {
    List<Chef> _list = getChefList();
    for(Chef _con in _list) {
      if(_con.email.compareTo(email) == 0) {
        return _con;
      }
    }
    return null;
  }

  @override
  Future<void> loginChangeScreen(Account _acc, BuildContext context) async {
    await Future.delayed(Duration(seconds: 5), () {
      if(_acc.role == Account_Type.values[0]) {
        Navigator.pushNamed(context, "/main", arguments: {
          'acc' : _acc
        });
      }else if(_acc.role == Account_Type.values[1]) {
        Navigator.pushNamed(context, "/chef", arguments: {
          'acc' : _acc
        });
      }
    });
  }

  @override
  Future<void> regChangeScreen(Consumer _acc, BuildContext context) async {
    await Future.delayed(Duration(seconds: 5), () {
      Navigator.pushNamed(context, "/reg2", arguments: {
        'acc' : _acc
      });
    });
  }

  @override
  List<Chef> getChefList() {
   return [
     Chef(email: "dongocduy@gmail.com", name: "Duy Do", password: "duy123",
       addr: "Cao Thang",
       role: Account_Type.values[1],
       phone: "0981874736",
       avatar: "assets/chef2.jpg",
       star: 4.5,
       price: 50000,

     ),
     Chef(email: "tranquangminh@gmail.com", name: "Minh Tran", password: "minh123",
         addr: "phan van tri",
         role: Account_Type.values[1],
         phone: "0981874736",
         avatar: "assets/chef1.jpg",
         star: 5,
         price: 45000
     ),
     Chef(email: "phamnguyentrunghieu@gmail.com", name: "Hieu Pham", password: "minh123",
         addr: "Thu Duc",
         role: Account_Type.values[1],
         phone: "0981874736",
         avatar: "assets/chef3.jpg",
         star: 4.0,
         price: 60000
     ),
     Chef(email: "nguyenngocphieu@gmail.com", name: "Phieu Nguyen", password: "minh123",
         addr: "Duong so ba",
         role: Account_Type.values[1],
         phone: "0981874736",
         avatar: "assets/chef4.jpg",
         star: 3.5,
         price: 90000
     ),
     Chef(email: "phamngocnhan@gmail.com", name: "Nhan Pham", password: "minh123",
         addr: "Nguyen Dinh Chieu",
         role: Account_Type.values[1],
         phone: "0981874736",
         avatar: "assets/chef5.jpg",
         star: 3.0,
         price: 65000
     ),
   ];
  }

  @override
  List<Consumer> getConsumerList() {
    return [
      Consumer(
          email: 'minhtq2197@gmail.com', name: "minhtq2197",
          phone: "0981874736",password: "minhtq2197", addr: "nguyenvancu39", role: Account_Type.values[0]
      ),

      Consumer(
          email: 'nguyenduongmainhung@gmail.com', name: "nhung2611",
          phone: "0981874736",password: "nhung2611", addr: "caothang10", role: Account_Type.values[0]
      ),

      Consumer(
          email: 'denvau@gmail.com', name: "denvau1305",
          phone: "0981874736",password: "denvau1305", addr: "thaibinh54", role: Account_Type.values[0]
      ),
    ];
  }

  @override
  List<Food> getFoodList() {
    return [
      Food(id: 1, name: "Barbeque", avatar: "assets/Barbeque.jpg"),
      Food(id: 2, name: "Fry rice", avatar: "assets/fryrice.jpg"),
      Food(id: 3, name: "Pho", avatar: "assets/pho.jpg"),
      Food(id: 4, name: "Soup", avatar: "assets/soup.jpg"),
      Food(id: 5, name: "Spaghetti", avatar: "assets/spaghetti.png"),
    ];
  }

  @override
  List<ChefFood> getChefFood() {
    return [
      ChefFood(chefEmail: "dongocduy@gmail.com", foodId: 1),
      ChefFood(chefEmail: "dongocduy@gmail.com", foodId: 2),
      ChefFood(chefEmail: "dongocduy@gmail.com", foodId: 3),
      ChefFood(chefEmail: "dongocduy@gmail.com", foodId: 4),
      ChefFood(chefEmail: "dongocduy@gmail.com", foodId: 5),
      ChefFood(chefEmail: "tranquangminh@gmail.com", foodId: 1),
      ChefFood(chefEmail: "tranquangminh@gmail.com", foodId: 2),
      ChefFood(chefEmail: "tranquangminh@gmail.com", foodId: 3),
      ChefFood(chefEmail: "tranquangminh@gmail.com", foodId: 4),
      ChefFood(chefEmail: "tranquangminh@gmail.com", foodId: 5),
      ChefFood(chefEmail: "phamnguyentrunghieu@gmail.com", foodId: 1),
      ChefFood(chefEmail: "phamnguyentrunghieu@gmail.com", foodId: 2),
      ChefFood(chefEmail: "phamnguyentrunghieu@gmail.com", foodId: 3),
      ChefFood(chefEmail: "phamnguyentrunghieu@gmail.com", foodId: 4),
      ChefFood(chefEmail: "phamnguyentrunghieu@gmail.com", foodId: 5),
      ChefFood(chefEmail: "nguyenngocphieu@gmail.com", foodId: 1),
      ChefFood(chefEmail: "nguyenngocphieu@gmail.com", foodId: 2),
      ChefFood(chefEmail: "nguyenngocphieu@gmail.com", foodId: 3),
      ChefFood(chefEmail: "nguyenngocphieu@gmail.com", foodId: 4),
      ChefFood(chefEmail: "nguyenngocphieu@gmail.com", foodId: 5),
      ChefFood(chefEmail: "phamngocnhan@gmail.com", foodId: 1),
      ChefFood(chefEmail: "phamngocnhan@gmail.com", foodId: 2),
      ChefFood(chefEmail: "phamngocnhan@gmail.com", foodId: 3),
      ChefFood(chefEmail: "phamngocnhan@gmail.com", foodId: 4),
      ChefFood(chefEmail: "phamngocnhan@gmail.com", foodId: 5),
    ];
  }

}