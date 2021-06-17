import 'package:hci_201/model/chef.dart';
import 'package:hci_201/model/food.dart';
import 'package:hci_201/service/iservice.dart';
import 'package:hci_201/service/serviceimpl.dart';


class ChefFood {

  String chefEmail;
  int foodId;
  IService service = ServiceImpl();

  // constructor
  ChefFood({this.chefEmail, this.foodId});

  Food getFood() {
    return service.getFoodByID(this.foodId);
  }

  Chef getChef() {
    return service.getChefByEmail(this.chefEmail);
  }

}