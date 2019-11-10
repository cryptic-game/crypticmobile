import 'dart:convert';

import 'package:CrypticMobile/Websocket/AuthClient.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  TextStyle style =
      TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.white);

  final userController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  TextField userField;
  TextField emailField;
  TextField passwordField;
  TextField passwordConfirmField;

  @override
  Widget build(BuildContext context) {
    userField = TextField(
        controller: userController,
        obscureText: false,
        style: style,
        decoration: new InputDecoration(
          hintText: "Username",
          helperText: "Username",
        ));

    emailField = TextField(
        controller: emailController,
        obscureText: false,
        style: style,
        decoration:
            new InputDecoration(hintText: "Email", helperText: "Username"));

    passwordField = TextField(
        controller: passwordController,
        obscureText: true,
        style: style,
        decoration: new InputDecoration(
            hintText: "Password", helperText: "Type in password"));

    passwordConfirmField = TextField(
        controller: passwordConfirmController,
        obscureText: true,
        style: style,
        decoration: new InputDecoration(
            hintText: "Password", helperText: "Confirm your password"));

    final registerButton = RaisedButton(
      color: Color(0xff01A0C7),
      padding: const EdgeInsets.all(0.0),
      onPressed: () async {
        var username = userController.text;
        var password = passwordController.text;
        var passwordConfirm = passwordConfirmController.text;
        var email = emailController.text;

        if (password == passwordConfirm)
          AuthClient().register(
              username: username,
              email: email,
              password: password,
              onRegister: () {},
              onInvalidEmail: () => emailController.clear(),
              onInvalidPassword: () {
                passwordController.clear();
                passwordConfirmController.clear();
                //TODO Show error Message
              },
              onMissingParameters: () => key.currentState.showSnackBar(SnackBar(
                    content: Text("Missing Parameters"),
                  )),
              onTimeout: () => key.currentState.showSnackBar(SnackBar(
                    content: Text("Network Timeout"),
                  )),
              onUsernameExists: () {
                userController.clear();
                key.currentState.showSnackBar(SnackBar(
                  content: Text("Username already Exists"),
                ));
              },
              onUnknownError: () {
                key.currentState
                    .showSnackBar(SnackBar(content: Text("Unknwon Error!")));
              });
        else {
          passwordConfirmController.clear();
          passwordController.clear();
          key.currentState.showSnackBar(SnackBar(
            content: Text("Not the Same Password"),
          ));
        }
      },
      child: Text('Register',
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0)),
    );

    final loginButton = OutlineButton(
      highlightedBorderColor: Colors.black,
      onPressed: () {
        Navigator.pushReplacementNamed(context, "/login");
      },
      child: const Text('Login'),
    );

    return Scaffold(
      key: key,
      body: SingleChildScrollView(
          child: Center(
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
                  child: Text("Cryptic Mobile || Register", style: style),
                ),
                SizedBox(
                  height: 75.0,
                ),
                userField,
                emailField,
                passwordField,
                passwordConfirmField,
                loginButton,
                registerButton,
              ],
            ),
          ),
        ),
      )),
    );
  }

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void dataHandler(data) {
    print(data);
    var json = jsonDecode(data);
    if (json.containsKey("token")) {
      Navigator.pushReplacementNamed(context, "/home");
    } else if (json.containsKey("error")) {
      if (json['error'] == "permissions denied") {
        passwordController.clear();
      }
    }
  }
}
