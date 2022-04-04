import 'package:pyxl_assignment/models/user/user.dart';

class AuthState {
  final User? user;

  AuthState({required this.user});

  factory AuthState.initial() {
    return AuthState(
      user: null,
    );
  }

  factory AuthState.loggedIn(User user) {
    return AuthState(
      user: user,
    );
  }

  factory AuthState.loggedOut() {
    return AuthState(
      user: null,
    );
  }
}
