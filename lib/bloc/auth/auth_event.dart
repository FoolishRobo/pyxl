import 'package:pyxl_assignment/models/user/user.dart';

abstract class AuthEvent {}

class UserLogedIn extends AuthEvent {
  final User user;

  UserLogedIn({required this.user});
}

class UserLoggedOut extends AuthEvent {}
