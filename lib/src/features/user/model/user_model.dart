import 'package:attendance_tracka/src/core/model/base_model.dart';

class User extends BaseModel {
  final String firstName;
  final String lastName;
  final UserType type;
  User({this.firstName, this.lastName, this.type});

  @override
  User fromJson(Map<String, dynamic> json) {
    return null;
  }

  @override
  List<Object> get props => [firstName, lastName, type];

  @override
  Map<String, dynamic> toJson() {
    return null;
  }
}

enum UserType { participant, organizer, volunteers }
