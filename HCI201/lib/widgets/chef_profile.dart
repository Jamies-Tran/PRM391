import 'package:flutter/material.dart';
import 'package:hci_201/model/chef.dart';
import 'package:hci_201/model/chef_food.dart';
import 'package:hci_201/model/consumer.dart';
import 'package:hci_201/model/food.dart';
import 'package:hci_201/service/iservice.dart';
import 'package:hci_201/service/serviceimpl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hci_201/widgets/chef_food_card.dart';
import 'package:hci_201/widgets/follower.dart';

class ChefProfile extends StatefulWidget {

  List<Chef> _listFollowed = [];

  @override
  _ChefProfileState createState() => _ChefProfileState();
}

class _ChefProfileState extends State<ChefProfile> {
  String email;
  IService service;
  List<ChefFood> _chefFoodList = [];
  bool isFollowed = false;


  @override
  Widget build(BuildContext context) {

    Map data = ModalRoute.of(context).settings.arguments;
    email = data['chef'];
    Consumer _con = data["acc"];
    service = ServiceImpl();
    Chef _chef =  service.getChefByEmail(email);
    _chefFoodList.addAll(service.getChefFood().where((element) => element.chefEmail == _chef.email));
    Food _food(int id) => service.getFoodByID(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Chef's information",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'robo',
              letterSpacing: 2.0
            ),
        ),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(28),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("${_chef.avatar}"),
                  radius: 100,
                ),
              ),
              SizedBox(height: 30),
              RatingBar(
                  initialRating: _chef.star,
                  itemCount: 5,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  ratingWidget: RatingWidget(
                    full: Icon(
                        Icons.star,
                        color: Colors.redAccent
                    ),
                    half: Icon(
                        Icons.star_half,
                        color: Colors.redAccent
                    ),
                    empty: Icon(
                        Icons.star_border_outlined,
                        color: Colors.redAccent
                    )
                  ),
                  onRatingUpdate: (_value) {},
                  ignoreGestures: true,
              ),
              SizedBox(height: 30),
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width,
                height: 50,
                child: Follower(con: _con, chefFollower: _chef)
              ),
              SizedBox(height: 30),
              Divider(
                color: Colors.redAccent,
                thickness: 1.0,
              ),
              SizedBox(height: 30),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Name: ",
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'robo',
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "${_chef.name}",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'robo',
                              letterSpacing: 1.0
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          "Email: ",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'robo',
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "${_chef.email}",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'robo',
                              letterSpacing: 1.0
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          "Phone: ",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'robo',
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "${_chef.phone}",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'robo',
                              letterSpacing: 1.0
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          "Address: ",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'robo',
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "${_chef.addr}",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'robo',
                              letterSpacing: 1.0
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    Text(
                      "Food service",
                      style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'robo',
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_border_outlined,
                          color: Colors.redAccent,
                          size: 25,
                        ),
                        Icon(
                          Icons.star_border_outlined,
                          color: Colors.redAccent,
                          size: 50,
                        ),
                        Icon(
                          Icons.star_border_outlined,
                          color: Colors.redAccent,
                          size: 25,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 1,
                  child: ChefFoodCard(chefFoodList: _chefFoodList),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
