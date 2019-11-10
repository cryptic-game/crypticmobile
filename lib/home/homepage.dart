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
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
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

                    if (!await AuthClient().isLogin()) {
                      var token =
                          await CrypticMobile.storage.read(key: "token");

                      AuthClient().loginSession(
                          token: token,
                          onLogin: () {
                            startGame();
                          },
                          onTimeout: () {
                            key.currentState.showSnackBar(SnackBar(
                              content: Text("Not Connected to the Internet"),
                            ));
                          },
                          onLogout: () {
                            NavigationService.pushNamedReplacement("/login");
                          });
                    }
                    else {
                      startGame();
                    }

                } else
                  NavigationService.pushNamedReplacement("/login");
              },
            )
          ],
        ),
      ),
    );
  }

  void startGame(){
    //TODO Game need to be Started
    key.currentState.showSnackBar(SnackBar(
      content: Text("Soon --> Already Login"),
    ));
    print("Logout User to Test Things");
    CrypticMobile.storage.deleteAll();
    Request('{"action":"logout"}').subscribe((data){
      print(data);
    });
  }
}
