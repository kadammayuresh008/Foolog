import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget>[
          Text("Foolog",
            style:TextStyle(
              fontSize: 60.0,
              color: Colors.purple,
              fontFamily: 'Pacifico'
              // fontWeight: FontWeight.bold,
            ),),
          SizedBox(height:20.0),
          CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.purple),
            backgroundColor: Colors.white,
          ),
        ],

      ),

    );
  }
}
