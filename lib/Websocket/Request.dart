import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:CrypticMobile/Websocket/CrypticSocket.dart';
import 'package:flutter/material.dart';

class Request {
  static Request activeRequest;
  Function requestCallback;
  var requestAnswer;
  var requestData;
  bool requestReturned = false;

  Request(json) {
    requestData = json;
    sendRequest();
  }

  void sendRequest()async{
    while (activeRequest != null) {
      sleep(Duration(milliseconds: 250));
    }

    CrypticSocket.getInstance().sendRequest(this);
  }

  void handle(var json) async {
    if (json.containsKey("tag")) {
      requestAnswer = json["data"];
    } else {
      requestAnswer = json;
    }
    closeRequest();
  }

  void closeRequest() {
    if (!requestReturned) {
      requestReturned = true;
      activeRequest = null;
      if (requestAnswer == null) requestAnswer = jsonDecode("{}");
      if (requestCallback != null) {
        requestCallback(requestAnswer);
      }
    }
  }

  subscribe(Function callback) async {
    requestCallback = callback;
    var timer = new Timer(const Duration(seconds: 30), () {
      closeRequest();
    });
  }

}
