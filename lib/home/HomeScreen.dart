import 'package:CrypticMobile/GlobalDesign/GlobalDrawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Cryptic Mobile")),
        drawer: GlobalDrawer(),
      body:
      Wrap(children: <Widget>[
        Image(
          image: AssetImage('assets/cryptic.png'),
        ),
        Text("This is the Homescreen --> You are logged in!")
      ],)



    );
  }

}