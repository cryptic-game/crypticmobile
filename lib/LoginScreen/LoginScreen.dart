import 'package:CrypticMobile/NavigationService.dart';
import 'package:CrypticMobile/Websocket/AuthClient.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  TextStyle style =
      TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.white);

  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userField = TextField(
        controller: userController,
        obscureText: false,
        style: style,
        decoration: new InputDecoration(
            hintText: "Username", helperText: "Please enter your Username"));

    final passwordField = TextField(
        controller: passwordController,
        obscureText: true,
        style: style,
        decoration: new InputDecoration(
            hintText: "Password", helperText: "Please enter your password"));

    final loginButon = RaisedButton(
      color: Color(0xff01A0C7),
      padding: const EdgeInsets.all(0.0),
      onPressed: () async {
        var username = userController.text;
        var password = passwordController.text;

        if (! await AuthClient().isLogin())
        AuthClient().login(
            username: username,
            password: password,
            onLogin: () {
              NavigationService.pushNamedReplacement("/home");
            },
            onLoginFailed: () {
              passwordController.clear();
              key.currentState.showSnackBar(SnackBar(
                content: Text("Login Failed"),
              ));
            });
        else NavigationService.pushNamedReplacement("/start");
      },
      child: Text('Login',
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0)),
    );

    return Scaffold(
      key: key,
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 10.0,
              children: <Widget>[
                ClipOval(
                  child: Image.asset(
                    "assets/cryptic.png",
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
                Center(
                  child: Text("Cryptic Mobile || Login", style: style),
                ),
                SizedBox(
                  height: 75.0,
                ),
                userField,
                passwordField,
                loginButon,
                OutlineButton(
                  highlightedBorderColor: Colors.black,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/register");
                  },
                  child: const Text('Register'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }


}
