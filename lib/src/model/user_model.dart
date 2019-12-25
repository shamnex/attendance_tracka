class User {
  final String firstName;
  final String lastName;
  final UserType type;

  User({this.firstName, this.lastName, this.type});
}

enum UserType { participant, organizer, volunteers }
