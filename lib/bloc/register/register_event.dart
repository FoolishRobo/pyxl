abstract class RegisterEvent {}

class FirstNameInputChanged extends RegisterEvent {
  final String firstName;

  FirstNameInputChanged({required this.firstName});
}

class SecondNameInputChanged extends RegisterEvent {
  final String secondName;

  SecondNameInputChanged({required this.secondName});
}

class UserNameInputChanged extends RegisterEvent {
  final String username;

  UserNameInputChanged({required this.username});
}

class PasswordInputChanged extends RegisterEvent {
  final String password;

  PasswordInputChanged({required this.password});
}

class RegisterButtonPressed extends RegisterEvent {
  final String id;
  final String firstName;
  final String secondName;
  final String image;
  final List<String> contactUserIds;
  final String username;
  final String password;

  RegisterButtonPressed(
      {required this.id,
      required this.firstName,
      required this.secondName,
      required this.image,
      required this.contactUserIds,
      required this.username,
      required this.password});
}
