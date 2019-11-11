import 'package:CrypticMobile/LoginScreen/LoginScreen.dart';
import 'package:CrypticMobile/LoginScreen/RegisterScreen.dart';
import 'package:CrypticMobile/NavigationService.dart';
import 'package:CrypticMobile/Websocket/AuthClient.dart';
import 'package:CrypticMobile/home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'Websocket/CrypticSocket.dart';
import 'home/startScreen.dart';

void main() {
  CrypticSocket socket = CrypticSocket();
  runApp(CrypticMobile());
}

class CrypticMobile extends StatelessWidget {
  static final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cryptic Mobile',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.green,
        ),
        home: StartScreen(),
        navigatorKey: NavigationService.navigatorKey,
        routes: {
          "/start": (_) => new StartScreen(),
          "/login": (_) => new LoginScreen(),
          "/register": (_) => new RegisterScreen(),
          "/home": (_) => new HomeScreen(),
        });
  }
}
