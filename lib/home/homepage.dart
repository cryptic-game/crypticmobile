import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cryptic Mobile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image(
              image: AssetImage('assets/cryptic.png'),
            ),
            Text(
              '\nWelcome to Cryptic Mobile',
              textScaleFactor: 2,
            ),
          ],
        ),
      ),
    );
  }
}
