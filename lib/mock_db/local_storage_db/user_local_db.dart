import 'package:pyxl_assignment/models/user/user.dart';
import 'package:sqflite/sqflite.dart';

final String tableUser = 'user';
final String columnFirstName = 'firstName';
final String columnSecondName = 'secondName';
final String columnImage = 'image';
final String columnUserName = 'userName';
final String columnPassword = 'password';
final String columnContactUserIds = 'contactUserIds';

class UserLocalDb {
  late Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table user (
  $columnFirstName text not null,
  $columnSecondName text not null,
  $columnImage text not null,
  $columnUserName text primary key not null,
  $columnPassword text not null,
  $columnContactUserIds text not null)
''');
    });
  }

  Future<void> insert(User user) async {
    await db.insert(tableUser, user.toMap());
  }

  Future<List<User>?> getUsers() async {
    List<Map> users = await db.query(tableUser);
    if (users.length > 0) {
      return users.map((e) => User.fromMap(e)).toList();
    }
    return null;
  }

  Future<User?> getUser(String username) async {
    List<Map> maps = await db
        .query(tableUser, where: '$columnUserName = ?', whereArgs: [username]);
    if (maps.length > 0) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(String username) async {
    return await db
        .delete(tableUser, where: '$columnUserName = ?', whereArgs: [username]);
  }

  Future<int> update(User user) async {
    return await db.update(tableUser, user.toMap(),
        where: '$columnUserName = ?', whereArgs: [user.username]);
  }

  Future close() async => db.close();
}
