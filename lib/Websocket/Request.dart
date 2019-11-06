import 'dart:convert';
import 'dart:io';

import 'package:CrypticMobile/Websocket/CrypticSocket.dart';

class Request {
  static Request activeRequest;
  Function callback;
  var requestAnswer;
  var requestData;

  Request(var json) {
    print("Create Request");
    while (activeRequest != null) {
      sleep(Duration(milliseconds: 250));
    }
    requestData = json;
    CrypticSocket.getInstance().sendRequest(this);
  }

  void handle(var json)async {
    print(json);
    if (json.containsKey("tag")) {
      requestAnswer = json["data"];
    } else {
      requestAnswer = json;
    }
  }

  subscribe(Function callback) async{


    int k = 0;
    while (requestAnswer == null && k < 40) {
      sleep(Duration(milliseconds: 250));
      k++;
    }

    activeRequest = null;

    if (requestAnswer == null) requestAnswer = jsonDecode("{}");
    if (callback != null) {
      callback(requestAnswer);
    }
  }
}
