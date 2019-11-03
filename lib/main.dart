import 'dart:io';

import 'package:flutter/material.dart';

void main() => runApp(CrypticMobile());

class CrypticMobile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cryptic Mobile',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginPage(title: 'Cryptic Mobile'),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image(image:  AssetImage('assets/cryptic.png'),),
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
