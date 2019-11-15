import 'package:CrypticMobile/Websocket/Request.dart';
import 'package:uuid/uuid.dart';

class Device {
  var uuid;
  String name;
  var owner;
  bool powered;

  Device({var uuid, String name, var owner, bool powered}) {
    this.uuid = uuid;
    this.name = name;
    this.owner = owner;
    this.powered = powered;
  }

  static Device getDeviceByUUID(var uuid) {
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
    });

    return device;
  }
}
