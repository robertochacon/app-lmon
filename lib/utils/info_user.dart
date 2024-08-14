import 'package:hive/hive.dart';

class InfoUser {

  _hive() async {
    return await Hive.openBox('userBox');
  }

  String getToken() {
    _hive();
    var box = Hive.box('userBox');
    return box.get('token', defaultValue: ''); 
  }

  String getIdentification() {
    _hive();
    var box = Hive.box('userBox');
    return box.get('identification', defaultValue: ''); 
  }

  String getName() {
    _hive();
    var box = Hive.box('userBox');
    return box.get('name', defaultValue: ''); 
  }

  String getEmail() {
    _hive();
    var box = Hive.box('userBox');
    return box.get('email', defaultValue: ''); 
  }

}