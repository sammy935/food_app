import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  final storage = GetStorage(); // instance of getStorage class

  PreferenceManager._privateConstructor();

  static final PreferenceManager instance =
      PreferenceManager._privateConstructor();

  final String _pUser = 'isLogin';

  void addUser(bool val) {
    storage.write(_pUser, val);
  }

  bool? get readUser {
    return storage.read(_pUser);
  }

  void get removeUser {
    storage.remove(_pUser);
  }
}
