library user_model;

import 'package:attendance_tracka/src/core/built_value/serializers.dart';
import 'package:attendance_tracka/src/core/model/base_model.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_model.g.dart';

//  {
//   "ORGANISATION_NAME": "Shamnex Corps",
//   "ORGANISATIONN_ABB": "shamnex",
//   "email": "shamnex@icloud.como",
//   "API_URL": "api_url_here_oh",
// }

abstract class User with BaseModel implements Built<User, UserBuilder> {
  @nullable
  String get email;

  @nullable
  @BuiltValueField(wireName: 'ORGANISATION_NAME')
  String get organization;

  @BuiltValueField(wireName: 'ORGANISATIONN_ABB')
  String get userName;

  @BuiltValueField(wireName: 'API_URL')
  String get apiURL;

  @nullable
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
  static const UserType volunteer = _$volunteer;
  const UserType._(String name) : super(name);
  static BuiltSet<UserType> get values => _$values;
  static UserType valueOf(String name) => _$valueOf(name);
  static Serializer<UserType> get serializer => _$userTypeSerializer;
}
