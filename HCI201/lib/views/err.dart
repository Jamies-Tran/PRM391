import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  const Error({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context).settings.arguments;
    final String err = data['err'];
    return Container(
      child: Center(
        child: Text("$err"),
      ),
    );
  }
}
