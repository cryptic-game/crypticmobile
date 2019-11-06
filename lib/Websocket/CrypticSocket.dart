import 'dart:async';
import 'dart:convert';

import 'package:CrypticMobile/Websocket/Request.dart';
import 'package:web_socket_channel/io.dart';

class CrypticSocket {
  Timer timer;

  static CrypticSocket socket;

  IOWebSocketChannel channel;

  CrypticSocket() {
    socket = this;
    channel = IOWebSocketChannel.connect("wss://ws.test.cryptic-game.net/");


    /*channel.stream.listen((data) => (data) {
      print("This is Sparta");
      print(data);
      print(Request.activeRequest);
      //if (Request.activeRequest != null)
      //  Request.activeRequest.handle(jsonDecode(data));
    });
    */

    channel.stream.listen((data) {
      handledData(data);
    }, onDone: () {
      print("Task Done");
    }, onError: (error) {
      print("Some Error");
    });


    /*timer = Timer.periodic(
        Duration(seconds: 25),
        (Timer t) => () {
              Request(jsonDecode('{"action":"info"}').toString())
                  .subscribe((data) {});
            });*/
  }

  static CrypticSocket getInstance() => socket;

  sendRequest(Request request) async {
    print("sendRequesrt");
    Request.activeRequest = request;
    print("Request.data" + request.requestData.toString());
    channel.sink.add(request.requestData.toString());
  }

  void handledData(var data)async{
    print("DataHandled" +data);
    print(Request.activeRequest);
    if (Request.activeRequest != null)
      Request.activeRequest.handle(jsonDecode(data));
  }
}
