import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'CrypticSocket.dart';

class Request {
  static Request activeRequest;
  Function requestCallback;
  var requestAnswer;
  var requestData;
  bool requestReturned = false;
  Completer c;

  Request(json) {
    requestData = json;
    sendRequest();
  }

  void sendRequest() async {
    while (activeRequest != null) {
      sleep(Duration(milliseconds: 250));
    }

    var timer = new Timer(const Duration(seconds: 15), () {
      print("Request (" + requestData + ") was closed after 15 seconds!");
      closeRequest();
    });
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
      if (activeRequest == this) activeRequest = null;
      if (requestAnswer == null) requestAnswer = jsonDecode("{}");

      if (requestCallback != null) requestCallback(requestAnswer);
      if (c != null) c.complete(requestAnswer);
    }
  }

  subscribe(Function callback) async {
    requestCallback = callback;
  }

  Future<dynamic> asFuture() {
    c = new Completer();
    return c.future;
  }

  static Request buildRequest(
      {@required String ms,
      @required String endpoint,
      @required String data,
      @required Function callback}) {
    return Request({
      'tag': new Uuid().v4(),
      'ms': ms,
      'endpoint': endpoint,
      'data': data
    }).subscribe(callback);
  }
}
