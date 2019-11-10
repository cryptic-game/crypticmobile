import 'dart:async';

import 'package:CrypticMobile/NavigationService.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'Request.dart';

class AuthClient {
  void register(
      {@required String username,
      @required String email,
      @required String password,
      @required Function onRegister,
      Function onMissingParameters,
      Function onUsernameExists,
      Function onInvalidPassword,
      Function onInvalidEmail,
      Function onUnknownError,
      Function onTimeout}) {
    Request('{"action":"register","name":"$username","mail":"$email","password":"$password"}')
        .subscribe((var data) async {
      if (data.containsKey("token")) {
        await CrypticMobile.storage.write(key: "token", value: data['token']);
        if (onRegister != null) onRegister();
      } else if (data.containsKey("error")) {
        switch (data["error"]) {
          case "missing parameters":
            print("AuthClient.register() --> Missing Parameters");
            if (onMissingParameters != null) onMissingParameters();
            break;

          case "invalid password":
            if (onInvalidPassword != null) onInvalidPassword();
            print("AuthClient.register() --> invalid password");
            break;

          case "invalid email":
            if (onInvalidEmail != null) onInvalidEmail();
            print("AuthClient.register() --> invalid email");
            break;

          case "username already exists":
            if (onUsernameExists != null) onUsernameExists();
            print("AuthClient.register() --> username already exists");
            break;

          default:
            if (onUnknownError != null) onUnknownError();
            print("AuthClient.register() --> unknow Error");
            break;
        }
      } else {
        if (onTimeout != null) onTimeout();
        print("AuthClient.register() --> Connection Timeout");
      }
    });
  }

  void login(
      {@required String username,
      @required String password,
      Function onLogin,
      Function onLoginFailed}) {
    Request('{"action": "login", "name": "$username", "password": "$password"}')
        .subscribe((var data) async {
      if (data.containsKey("token")) {
        await CrypticMobile.storage.write(key: "token", value: data['token']);
        if (onLogin != null)
          onLogin();
        else
          NavigationService.pushNamed("/home");
      } else {
        if (onLoginFailed != null)
          onLoginFailed();
        else
          NavigationService.pushNamedReplacement("/login");
      }
    });
  }

  void loginSession(
      {@required String token,
      @required Function onLogin,
      Function onTimeout,
      Function onLogout}) {
    Request('{"action":"session","token":"$token"}').subscribe((data) async {
      if (data.containsKey("token")) {
        await CrypticMobile.storage.write(key: "token", value: data['token']);
        if (onLogin != null) onLogin();
      } else if (data.containsKey("error")) {
        await CrypticMobile.storage.delete(key: "token");
        if (onLogout != null) onLogout();
      } else {
        if (onTimeout != null) {
          onTimeout();
        }
      }
    });
  }

  Future<dynamic> isLogin() {
    Completer c = new Completer();
    Request('{"action": "info"}').subscribe((var data) async {
      print(data);
      if (data.containsKey("error")) {
        c.complete(false);
      }else{
        c.complete(true);
      }
    });

    return c.future;


  }
}
