import 'package:flutter/material.dart';
import 'package:hci_201/model/account.dart';
import 'package:hci_201/model/chef.dart';
import 'package:hci_201/model/chef_food.dart';
import 'package:hci_201/model/consumer.dart';
import 'package:hci_201/model/food.dart';
import 'package:hci_201/service/iservice.dart';
import 'package:hci_201/service/serviceimpl.dart';

class FoodCard extends StatefulWidget {

  List<Food> foodList = [];
  Consumer con;

  FoodCard({this.foodList, this.con});

  @override
  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {

  IService service = ServiceImpl();

  void onTapFunc(int index) {
    Navigator.pushNamed(context, '/show_cooker', arguments: {
      'food' : widget.foodList[index],
      'acc' : widget.con
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.foodList.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: (){
                  onTapFunc(index);
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(14, 20, 10, 0),
                  width: MediaQuery.of(context).size.width * 0.47,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: AssetImage("${widget.foodList[index].avatar}"),
                      fit: BoxFit.cover
                    )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.15,
                child: Card(
                  child: ListTile(
                    title: Text(
                      '${widget.foodList[index].name}',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'koho',
                        letterSpacing: 2.0
                      ),
                    ),
                    onTap: (){
                      onTapFunc(index);
                    },
                  ),
                ),
              ),
              SizedBox(width: 30),
            ],
          );
        }
    );
  }
}
