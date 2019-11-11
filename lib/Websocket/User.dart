import 'Request.dart';

class User{
  static User currentUser;

  var username = '';
  var email = '';
  var uuid = '';
  var created = '';
  var last = '';
  User(){currentUser = this;}

  requestUserInformation(){
    Request('{"action": "info"}').subscribe((var data) async {
      if (!data.containsKey("error")) {
        email = data['mail'];
        username = data['name'];
        uuid = data['uuid'];
        created = data['created'].toString();
        last = data['last'].toString();
      }
    });

  }
}