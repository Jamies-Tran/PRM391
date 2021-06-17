import 'package:hci_201/model/chef_food.dart';

class Food {
  int id;
  String name;
  String avatar;
  List<String> receiptList = [];
  List<ChefFood> chefFood = [];

  Food({this.id, this.name, this.receiptList, this.avatar});

}