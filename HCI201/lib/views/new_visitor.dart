import 'package:flutter/material.dart';

class Visitor extends StatefulWidget {
  const Visitor({Key key}) : super(key: key);

  @override
  _VisitorState createState() => _VisitorState();
}

class _VisitorState extends State<Visitor> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/index.png"),
            fit: BoxFit.cover
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonTheme(
                minWidth: 170,
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    'LOG IN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: Colors.red
                    ),
                  ),
                  color: Colors.white,

                ),
              ),
              SizedBox(width: 50,),
              ButtonTheme(
                  minWidth: 170,
                  height: 50,
                  buttonColor: Colors.red,
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        isPressed = !isPressed;
                      });
                      Navigator.pushNamed(context, '/reg');
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          color: isPressed ? Colors.white : Colors.red
                      ),
                    ),
                    color: isPressed ? Colors.red : Colors.white,
                  )
              )
            ],
          ),
        ),
      );
  }
}
