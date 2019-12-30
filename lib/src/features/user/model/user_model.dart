library user_model;

import 'package:attendance_tracka/src/core/built_value/serializers.dart';
import 'package:attendance_tracka/src/core/model/base_model.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_model.g.dart';

abstract class User with BaseModel implements Built<User, UserBuilder> {
  String get firstName;
  String get lastName;
  String get id;
  DateTime get createdAt;
  UserType get type;
  User._();

  factory User([updates(UserBuilder b)]) = _$User;
  static Serializer<User> get serializer => _$userSerializer;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(User.serializer, this);
  }

  static User fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(User.serializer, json);
  }
}

class UserType extends EnumClass {
  static const UserType participant = _$participant;
  static const UserType organizer = _$organizer;
  static const UserType volunteers = _$volunteer;

  const UserType._(String name) : super(name);

  static BuiltSet<UserType> get values => _$values;
  static UserType valueOf(String name) => _$valueOf(name);
  static Serializer<UserType> get serializer => _$userTypeSerializer;
}
