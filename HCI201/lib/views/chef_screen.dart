import 'package:flutter/material.dart';

class ChefScreen extends StatefulWidget {
  const ChefScreen({Key key}) : super(key: key);

  @override
  _ChefScreenState createState() => _ChefScreenState();
}

class _ChefScreenState extends State<ChefScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[500],
      child: Center(
        child: Text("this is chef screen"),
      ),
    );
  }
}
