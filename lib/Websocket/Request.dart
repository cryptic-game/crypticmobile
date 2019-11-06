import 'dart:convert';
import 'dart:io';

import 'package:CrypticMobile/Websocket/CrypticSocket.dart';

class Request {
  static Request activeRequest;
  Function callback;
  var data;

  Request(var json) {
    print("Create Request");
    while (activeRequest != null) {
      sleep(Duration(milliseconds: 250));
    }
    CrypticSocket.getInstance().sendRequest(this);
  }

  void handle(var json)async {
    print(json);
    if (json.containsKey("tag")) {
      data = json["data"];
    } else {
      data = json;
    }
  }

  subscribe(void onData(data)) async{


    int k = 0;
    while (data == null && k < 40) {
      sleep(Duration(milliseconds: 250));
      k++;
    }

    activeRequest = null;

    if (data == null) data = jsonDecode("{}");
    print("End of Subscribe!");
    print(data);
    if (callback != null) {
      onData(data);
    }
  }
}
