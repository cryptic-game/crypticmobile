import 'dart:async';
import 'dart:convert';

import 'package:CrypticMobile/Websocket/Request.dart';
import 'package:web_socket_channel/io.dart';

import 'User.dart';

class CrypticSocket {
  Timer timer;
  static const String ServerUrl = "wss://ws.test.cryptic-game.net/";
  static CrypticSocket socket;
  bool connectionOpen = false;

  IOWebSocketChannel _channel;

  CrypticSocket() {
    User();
    connectionOpen = true;
    socket = this;
    tryConnect();
    timer = new Timer.periodic(Duration(seconds: 25),
        (Timer t) => Request('{"action":"info"}').subscribe((data) {}));
  }

  static CrypticSocket getInstance() => socket;

  sendRequest(Request request, {int recall}) async {
    if (connectionOpen) {
      Request.activeRequest = request;
      _channel.sink.add(request.requestData.toString());
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
    print("(re)connect to Socket");

    _channel = null;
    _channel = IOWebSocketChannel.connect(ServerUrl);

    _channel.stream.listen((data) {
      print("CrypticSocket:   Data Recived");
      handledData(data);
    }, onDone: () {
      connectionOpen = false;
      print("CrypticSocket:   Socket connection closed!");
    }, onError: (error, StackTrace stackTrace) {
      print("CrypticSocket:   Error occurred in stream" + error);
      print(stackTrace);
    });
    connectionOpen = true;
  }

  void handledData(var data) async {
    if (Request.activeRequest != null)
      Request.activeRequest.handle(jsonDecode(data));
  }
}
