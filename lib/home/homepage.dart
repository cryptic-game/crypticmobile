import 'package:CrypticMobile/NavigationService.dart';
import 'package:CrypticMobile/Websocket/AuthClient.dart';
import 'package:CrypticMobile/Websocket/Request.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> skey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: skey,
      appBar: AppBar(title: Text("Cryptic Mobile")),
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
            RaisedButton(
              child: Text("Start Game!"),
              onPressed: () async {
                var token = await CrypticMobile.storage.read(key: "token");
                if (token != null) {
                  Request('{"action": "info"}').subscribe((var data) async {
                    if (data.containsKey("error")) {
                      var token =
                          await CrypticMobile.storage.read(key: "token");

                      AuthClient().loginSession(
                          token: token,
                          onLogin: () {
                            //TODO Start Game
                          },
                          onTimeout: () {
                            skey.currentState.showSnackBar(SnackBar(
                              content: Text("Not Connected to the Internet"),
                            ));
                          },
                          onLogout: () {
                            NavigationService.pushNamed("/login");
                          });
                    }
                  });
                } else
                  NavigationService.pushNamed("/login");
              },
            )
          ],
        ),
      ),
    );
  }
}
