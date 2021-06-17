import 'package:flutter/material.dart';
import 'package:hci_201/model/chef_food.dart';
import 'package:hci_201/model/food.dart';
import 'package:hci_201/service/iservice.dart';
import 'package:hci_201/service/serviceimpl.dart';

class ChefFoodCard extends StatelessWidget {

  List<ChefFood> chefFoodList = [];
  IService service = ServiceImpl();
  Food _getFood(int id) => service.getFoodByID(id);

  ChefFoodCard({this.chefFoodList});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListView.builder(
        itemCount: chefFoodList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
          return Row(
            children: [
              GestureDetector(
                onTap: (){},
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("${_getFood(chefFoodList[index].foodId).avatar}"),
                                fit: BoxFit.cover
                            ),
                            borderRadius: BorderRadius.circular(15)
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Text(
                          "${_getFood(chefFoodList[index].foodId).name}",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'robo'
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: 20)
            ],
          );
        },
      ),
    );
  }
}
