import 'package:flutter/material.dart';

const inputDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green, width: 1.0),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1.0),
  ),
  fillColor: Colors.white,
  filled: true
);

const textStyle15 = TextStyle(
  fontSize: 15,
  fontFamily: 'robo',
);

const textStyle20 = TextStyle(
  fontSize: 20,
  fontFamily: 'robo',
);

const textStyle25 = TextStyle(
  fontSize: 25,
  fontFamily: 'robo',
);

const textStyle30 = TextStyle(
  fontSize: 30,
  fontFamily: 'robo',
);

Widget myAppBar(String title) {
  return AppBar(
    title: Text("$title", style: textStyle15,),
    backgroundColor: Colors.green,
  );
}

const Map<int, String> statusOrder = {
  0 : 'Đã thêm vào giỏ',
  1 : 'Đã đặt hàng',
  2 : 'Đã hủy',
  3 : 'Đã hoàn thành'
};
