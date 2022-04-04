abstract class LoginEvent {}

class UserNameInputChanged extends LoginEvent {
  final String userName;

  UserNameInputChanged({required this.userName});
}

class PasswordInputChanged extends LoginEvent {
  final String password;

  PasswordInputChanged({required this.password});
}

class LoginButtonPressed extends LoginEvent {
  final String userName;
  final String password;

  LoginButtonPressed({required this.userName, required this.password});
}
