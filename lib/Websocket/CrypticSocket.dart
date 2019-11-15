import 'dart:async';
import 'dart:convert';

import 'package:CrypticMobile/Websocket/Request.dart';
import 'package:web_socket_channel/io.dart';

import 'User.dart';

class CrypticSocket {
  Timer timer;

  static CrypticSocket socket;
  bool connectionOpen = false;

  IOWebSocketChannel channel;

  CrypticSocket() {
    User();

    connectionOpen = true;
    socket = this;

    tryConnect();

    timer = new Timer.periodic(
        Duration(seconds: 25),
            (Timer t) => Request('{"action":"info"}').subscribe((data) {}));
  }

  static CrypticSocket getInstance() => socket;

  sendRequest(Request request, {int recall}) async {
    if (connectionOpen) {
      Request.activeRequest = request;
      channel.sink.add(request.requestData.toString());
    } else {
      socket.tryConnect();
      if (recall == null) {
        recall = 0;
      }
      print(recall);
      if (recall < 5) sendRequest(request, recall: recall + 1);
    }
  }

  void tryConnect() async {
    print("Reconnect Socket");

    channel = null;
    channel = IOWebSocketChannel.connect("wss://ws.test.cryptic-game.net/");
    channel.stream.listen((data) {
      handledData(data);
    }, onDone: () {
      connectionOpen = false;
      print("Task Done");
      print("Websocket Connection Closed");
    }, onError: (error) {
      print("Some Error");
    });
    connectionOpen = true;
  }

  void handledData(var data) async {
    if (Request.activeRequest != null)
      Request.activeRequest.handle(jsonDecode(data));
  }
}
