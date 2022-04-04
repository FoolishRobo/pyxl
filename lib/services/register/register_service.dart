import 'package:pyxl_assignment/mock_db/local_storage_db/user_local_db.dart';
import 'package:pyxl_assignment/models/error/respone_message.dart';
import 'package:pyxl_assignment/models/user/user.dart';

class RegisterService {
  UserLocalDb db = UserLocalDb();
  Future<ResponeMessage> registerUser(User user) async {
    await db.open('user.db');
    if (await _checkIfUserNameTaken(user.username))
      return ResponeMessage(isError: true, message: "Username already exists");
    try {
      await db.insert(user);
    } catch (e) {
      return ResponeMessage(isError: true, message: "Error $e");
    }

    return ResponeMessage(isError: false, message: "Registered successfully");
  }

  Future<bool> _checkIfUserNameTaken(String username) async {
    List<User>? users = await db.getUsers();
    if (users != null) {
      for (User user in users) {
        if (user.username == username) {
          return true;
        }
      }
    }
    return false;
  }
}
