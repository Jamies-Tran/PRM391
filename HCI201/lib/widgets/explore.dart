// ToDo: explore
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hci_201/model/chef_food.dart';
import 'package:hci_201/model/consumer.dart';
import 'package:hci_201/service/iservice.dart';
import 'package:hci_201/service/serviceimpl.dart';
import 'package:hci_201/widgets/chef_card.dart';
import 'package:hci_201/widgets/food_card.dart';

class Explore extends StatefulWidget {

  Consumer con;

  Explore({this.con});

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {

  List<ChefFood> chefFoodList = [];


  IService service = ServiceImpl();



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.png"),
                fit: BoxFit.cover
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(14, 50, 14, 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search chef...',
                  hintStyle: TextStyle(
                    fontSize: 20,
                    fontFamily: 'koho',
                    letterSpacing: 2.0
                  ),
                  // dat icon vao cuoi cua textfield (suffix - cuoi)
                  suffixIcon: Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.black),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.red),
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
                onTap: () {
                  //showSearch(context: context, delegate: SearchService());
                },
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  Text(
                      "Chef around me",
                      style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'koho',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                          color: Colors.redAccent
                      )
                  ),
                  Container(
                      width: 150,
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Divider(
                          color: Colors.redAccent,
                          thickness: 2.0,
                          height: 50
                      )
                  ),
                  Icon(Icons.people, size: 35, color: Colors.redAccent,)
                ],
              )
            ),
            SizedBox(height: 5),
            Container(
              // day la height cua container chua container cua cac chefcard
              height: MediaQuery.of(context).size.height * 0.65,
              child: ChefCard(chefList: service.getChefList(), con: widget.con, scrollDicrect: Axis.horizontal),
            ),
            SizedBox(height: 10),
            Center(
                child: Column(
                  children: [
                    Text(
                        "Recommanded",
                        style: TextStyle(
                            fontSize: 35,
                            fontFamily: 'koho',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                            color: Colors.redAccent
                        )
                    ),
                    Container(
                        width: 150,
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Divider(
                            color: Colors.redAccent,
                            thickness: 2.0,
                            height: 50
                        )
                    ),
                    Icon(Icons.fastfood, size: 35, color: Colors.redAccent)
                  ],
                )
            ),
            SizedBox(height: 30),
            Container(
              height: MediaQuery.of(context).size.height * 0.65,
              child: FoodCard(foodList: service.getFoodList(), con: widget.con),
            )
          ]
        ),
      ),
    );
  }
}
