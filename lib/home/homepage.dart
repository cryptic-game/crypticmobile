import 'package:CrypticMobile/Websocket/Request.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                if (await CrypticMobile.storage.read(key: "token") == null) {
                  Navigator.pushReplacementNamed(context, "/login");
                } else {
                  Request('{"action": "info"}')
                      .subscribe((var data) async {
                    if (data.containsKey("error")) {
                      var token = await CrypticMobile.storage.read(
                          key: "token");
                      Request('{"action":"session","token":"$token"}')
                          .subscribe((data) async {
                        if (data.containsKey("token")) {
                          print("Token Request Done " + data.toString());
                          print("Session now Valide");
                          await CrypticMobile.storage.delete(key: "token");
                          // TODO REDIRECT to main Screen
                        } else {
                          await CrypticMobile.storage.delete(key: "token");
                          Navigator.pushReplacementNamed(context, "/login");
                        }
                      });
                    }
                  });
                  //Navigator.pushReplacementNamed(context, "/home");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
