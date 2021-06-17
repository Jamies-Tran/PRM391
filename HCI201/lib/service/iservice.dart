import 'package:flutter/cupertino.dart';
import 'package:hci_201/model/account.dart';
import 'package:hci_201/model/chef.dart';
import 'package:hci_201/model/chef_food.dart';
import 'package:hci_201/model/consumer.dart';
import 'package:hci_201/model/food.dart';

abstract class IService {

  Food getFoodByID(int id);

  Food getFoodByName(String name);

  Future<void> errChangeScreen(String err, BuildContext context);

  Future<void> loginChangeScreen(Account _acc, BuildContext context);

  Future<void> regChangeScreen(Consumer _acc, BuildContext context);

  List<Account> getAccountList();

  List<Consumer> getConsumerList();

  List<Chef> getChefList();

  bool loginFunction(String email, String password, BuildContext context);

  List<Food> getFoodList();

  List<ChefFood> getChefFood();

  Chef getChefByEmail(String email);

  Consumer getConsumerByEmail(String email);
}