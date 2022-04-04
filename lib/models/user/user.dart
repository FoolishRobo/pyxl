import 'dart:convert';

import 'package:pyxl_assignment/models/contact/contact.dart';

class User extends Contact {
  String username;
  String password;
  List<dynamic> contactUserIds;

  User({
    required firstName,
    required secondName,
    required image,
    required this.username,
    required this.password,
    required this.contactUserIds,
  }) : super(firstName: firstName, secondName: secondName, image: image);

  factory User.fromMap(Map<dynamic, dynamic> user) {
    return User(
        firstName: user['firstName'],
        secondName: user['secondName'],
        image: user['image'],
        username: user['userName'],
        password: user['password'],
        contactUserIds: json.decoder.convert(user['contactUserIds']));
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'secondName': secondName,
      'image': image,
      'username': username,
      'password': password,
      'contactUserIds': json.encoder.convert(contactUserIds),
    };
  }
}
