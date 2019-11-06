import 'dart:async';
import 'dart:convert';

import 'package:CrypticMobile/Websocket/Request.dart';
import 'package:web_socket_channel/io.dart';

class CrypticSocket {
  Timer timer;

  static CrypticSocket socket;
  final IOWebSocketChannel channel =
      IOWebSocketChannel.connect("wss://ws.test.cryptic-game.net/");

  CrypticSocket() {
    socket = this;

    channel.stream.listen((data) {
      print(data);
      print(Request.activeRequest);
      if (Request.activeRequest != null)
        Request.activeRequest.handle(jsonDecode(data));
    }, onError: (error, StackTrace stackTrace) {
      print("Error" + error);
    }, onDone: () {
      print("Connection CLosed");
    });

    /*timer = Timer.periodic(
        Duration(seconds: 25),
        (Timer t) => () {
              Request(jsonDecode('{"action":"info"}').toString())
                  .subscribe((data) {});
            });*/
  }

  static CrypticSocket getInstance() => socket;

  sendRequest(Request request) async* {
    print("sendRequesrt");
    Request.activeRequest = request;
    channel.sink.add(request.data.toString());
  }
}
