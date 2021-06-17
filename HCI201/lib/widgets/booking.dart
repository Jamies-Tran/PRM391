import 'package:flutter/material.dart';


// ToDo: booking screen
class Booking extends StatefulWidget {
  const Booking({Key key}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}


class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Booking view"),
      ),
      color: Colors.grey[400],
    );
  }
}
