library sign_up_state;

import 'dart:convert';

import 'package:attendance_tracka/src/core/built_value/serializers.dart';
import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'signup_state.g.dart';

abstract class SignupState implements Built<SignupState, SignupStateBuilder> {
  // fields go here
  String get organization;
  String get password;
  String get email;
  String get errorMessage;
  String get apiURL;
  String get organizationUserName;
  @nullable
  User get user;

  bool get loading;
  bool get isSignedUp => user is User;
  bool get hasError => errorMessage.isNotEmpty;
  SignupState._();

  factory SignupState([updates(SignupStateBuilder b)]) = _$SignupState;

  static SignupState initialState() => SignupState(
        (b) => b
          ..organization = ''
          ..organizationUserName = ''
          ..password = ''
          ..email = ''
          ..errorMessage = ''
          ..loading = false
          ..apiURL = ''
          ..user = null,
      );

  String toJson() {
    return json.encode(serializers.serializeWith(SignupState.serializer, this));
  }

  static SignupState fromJson(String jsonString) {
    return serializers.deserializeWith(SignupState.serializer, json.decode(jsonString));
  }

  static Serializer<SignupState> get serializer => _$signupStateSerializer;
}
