import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  late final SharedPreferences _storage;

  PreferenceManager();

  final String _pUser = 'isLogin';
  final String screenSaverData = 'screenSaverData';

  Future<void> changeLoginStatus(bool val) async {
    _storage = await SharedPreferences.getInstance();
    await _storage.setBool(_pUser, val);
  }

  Future<void> addImageScreenSaver(List<String> val) async {
    _storage = await SharedPreferences.getInstance();
    await _storage.setStringList(screenSaverData, val);
  }

  Future<bool?> get readUser async {
    _storage = await SharedPreferences.getInstance();
    return _storage.getBool(_pUser);
  }

  void get removeUser {
    _storage.remove(_pUser);
  }
}
