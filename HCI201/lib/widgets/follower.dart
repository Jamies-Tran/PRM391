import 'package:flutter/material.dart';
import 'package:hci_201/model/chef.dart';
import 'package:hci_201/model/consumer.dart';

class Follower extends StatefulWidget {
  Consumer con;
  Chef chefFollower;
  List<Chef> _listChefFollower;

  Follower({this.con , this.chefFollower});

  @override
  _FollowerState createState() => _FollowerState();
}

class _FollowerState extends State<Follower> {

  bool config() {
    for(Chef c in widget._listChefFollower) {
      if(c.email.compareTo(widget.chefFollower.email) == 0) {
        return true;
      }
    }
    return false;
  }

  bool isAdd;

  @override
  void initState() {
    super.initState();
    widget._listChefFollower = widget.con.chefFollowed;
    isAdd = config();
  }

  void addOrRemoveChef() {
    if(isAdd == true) {
      widget._listChefFollower.add(widget.chefFollower);
      print("${widget.con.chefFollowed.length}");
    }else {
      // widget._listChefFollower.remove(widget.chefFollower);
      int index = widget._listChefFollower.indexOf(widget.chefFollower);
      widget._listChefFollower.removeAt(index);
      print("${widget.con.chefFollowed.length}");
    }
  }


  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
        onPressed: () {
          setState(() {
            isAdd = !isAdd;
            addOrRemoveChef();
            widget.con.chefFollowed = widget._listChefFollower;
          });

        },
        icon: isAdd == true ? Icon(Icons.thumb_up, size: 30) : Icon(Icons.thumb_up_outlined, size: 30),
        label: isAdd == true ? Text("UNFOLLOW", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: 3.0)) : Text("FOLLOW", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: 3.0)),
        color: isAdd == true ? Colors.green : Colors.redAccent,
    );
  }
}
