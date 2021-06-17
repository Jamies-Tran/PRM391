import 'package:flutter/material.dart';
import 'package:hci_201/model/chef.dart';
import 'package:hci_201/model/chef_food.dart';
import 'package:hci_201/model/consumer.dart';
import 'package:hci_201/model/food.dart';
import 'package:hci_201/service/iservice.dart';
import 'package:hci_201/service/serviceimpl.dart';
import 'package:hci_201/widgets/appbar.dart';
import 'package:hci_201/widgets/chef_card.dart';

class ShowCooker extends StatefulWidget {

  @override
  _ShowCookerState createState() => _ShowCookerState();
}

class _ShowCookerState extends State<ShowCooker> {
  List<ChefFood> _chefFoodList = [];

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;
    Food food = data['food'];
    Consumer con = data['acc'];
    IService service = ServiceImpl();
    List<Chef> _chefList = [];
    _chefFoodList.addAll(service.getChefFood().where((element) => element.foodId == food.id));
    _chefFoodList.sort((a,b) => service.getChefByEmail(a.chefEmail).star.compareTo(service.getChefByEmail(b.chefEmail).star));
    _chefFoodList = _chefFoodList.reversed.toList();
    _chefFoodList.forEach((element) {
      _chefList.add(service.getChefByEmail(element.chefEmail));
    });

    return Scaffold(
      appBar: MyAppBar(context, "All chef relate to this food"),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 1.6,
          child: ChefCard(scrollDicrect: Axis.vertical, chefList: _chefList, con: con),
        ),
      ),
    );
  }
}
