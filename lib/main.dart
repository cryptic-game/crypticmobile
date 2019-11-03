import 'dart:io';

import 'package:flutter/material.dart';

import 'home/homepage.dart';

void main() => runApp(CrypticMobile());

class CrypticMobile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cryptic Mobile',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
      routes: {
        "/home": (_) => new HomePage(),

      }
    );
  }
}


