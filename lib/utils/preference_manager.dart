// import 'package:get_storage/get_storage.dart';
//
// import '../model/user_model.dart';
//
// class PreferenceManager {
//   final storage = GetStorage(); // instance of getStorage class
//
//   final String _pUser = 'user';
//
//   void addUser(User user) {
//     storage.write(_pUser, user.toJson());
//   }
//
//   User? get readUser {
//     final res = storage.read(_pUser);
//     if (res != null) {
//       return User.fromJson(res);
//     } else {
//       return null;
//     }
//   }
//
//   void get removeUser {
//     storage.remove(_pUser);
//   }
// }
