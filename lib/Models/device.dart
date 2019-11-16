import 'dart:async';

import 'package:CrypticMobile/Websocket/Request.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Device {
  var uuid;
  String name;
  var owner;
  bool powered;

  Device(
      {@required var uuid,
      @required String name,
      @required var owner,
      @required bool powered}) {
    this.uuid = uuid;
    this.name = name;
    this.owner = owner;
    this.powered = powered;
  }

  static Future<dynamic> getDeviceByUUID(var uuid) {
    Completer c = new Completer();
    Device device;
    Request('{"ms":"device","endpoint":["device","info"],"data":{"device_uuid":"' +
            uuid +
            '"},"tag":"' +
            Uuid().v4() +
            '"}')
        .subscribe((data) {
      if (!data.containsKey('error')) {
        device = Device(
            name: data['name'],
            uuid: Uuid().parse(data['uuid']),
            owner: Uuid().parse(data['owner']),
            powered: data['powered_on']);

      }
      c.complete(device);
    });

    return c.future;
  }

  static Future<dynamic> getAllDevices() {
    Completer c = new Completer();
    List<Device> list = new List<Device>();

    Request('{"ms":"device","endpoint":["device","all"],"data":{},"tag":"' +
            Uuid().v4() +
            '"}')
        .subscribe((data) {
      if (!data.containsKey('error')) {
        for (var a in data['devices']) {
          list.add(Device(
              name: a['name'],
              uuid: Uuid().parse(a['uuid']),
              owner: Uuid().parse(a['owner']),
              powered: a['powered_on']));
        }
      }
      for (var i = 0; i < 5; i++) {
        list.add(Device(
            powered: true, name: "Big Berta", uuid: Uuid().v4(), owner: "Max"));
      }
      c.complete(list);
    });
    return c.future;
  }
}
