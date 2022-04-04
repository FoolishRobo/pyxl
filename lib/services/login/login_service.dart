import 'package:pyxl_assignment/mock_db/local_storage_db/user_local_db.dart';
import 'package:pyxl_assignment/models/user/user.dart';
import 'package:pyxl_assignment/services/shared_prefs/shared_prefs.dart';

class LoginService {
  UserLocalDb _db = UserLocalDb();
  SharedPref _sp = SharedPref();
  Future<User?> login(String username, String password) async {
    await _db.open('user.db');
    User? user = await _db.getUser(username);
    if (user != null) if (user.password == password) {
      await _sp.setString('currentLoggedInUserName', username);
      return user;
    }
    return null;
  }

  Future<void> logout() async {
    await _sp.remove('currentLoggedInUserName');
  }

  Future<User?> getLoggedInUser() async {
    SharedPref sp = SharedPref();
    String? username = await sp.getString('currentLoggedInUserName');
    if (username != null) {
      await _db.open('user.db');
      User? user = await _db.getUser(username);
      if (user == null) return null;
      return user;
    }
    return null;
  }
}
