class Contact {
  String firstName;
  String secondName;
  String image;

  Contact(
      {required this.firstName, required this.secondName, required this.image});

  factory Contact.fromMap(Map<dynamic, dynamic> user) {
    return Contact(
        firstName: user['firstName'],
        secondName: user['secondName'],
        image: user['image']);
  }

  Map<String, dynamic> toMap() {
    return {'firstName': firstName, 'secondName': secondName, 'image': image};
  }

  String fullName() {
    return this.firstName + " " + this.secondName;
  }
}
