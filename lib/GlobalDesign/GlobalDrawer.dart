import 'package:CrypticMobile/Websocket/AuthClient.dart';
import 'package:CrypticMobile/Websocket/User.dart';
import 'package:flutter/material.dart';

class GlobalDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
        child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          currentAccountPicture: ClipOval(
            child: Image.asset(
              "assets/cryptic.png",
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
          ),
          accountName: Text(User.currentUser.username),
          accountEmail: Text(User.currentUser.email),
        ),
        ListTile(
          title: Text("Home"),
          onTap: () {
            Navigator.pushReplacementNamed(context, "/home");
          },
        ),
        Divider(),
        ListTile(
          title: Text("Console"),
          onTap: () {
            Navigator.pushReplacementNamed(context, "/home");
          },
        ),
        ListTile(
          title: Text("Inventory"),
          onTap: () {
            Navigator.pushReplacementNamed(context, "/home");
          },
        ),ListTile(
          title: Text("Shop"),
          onTap: () {
            Navigator.pushReplacementNamed(context, "/home");
          },
        ),
        ListTile(
          title: Text("Miner"),
          onTap: () {
            Navigator.pushReplacementNamed(context, "/home");
          },
        ),
        Divider(),
        ListTile(
          title: Text("Settings"),
          onTap: () {
            Navigator.pushReplacementNamed(context, "/home");
          },
        ),
        ListTile(
          title: Text("Logout!"),
          onTap: () {
            AuthClient().logout();
          },
        ),
      ],
    ));
  }
}
