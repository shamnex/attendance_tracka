library login_up_state;

import 'dart:convert';

import 'package:attendance_tracka/src/core/built_value/serializers.dart';
import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'login_state.g.dart';

abstract class LoginState implements Built<LoginState, LoginStateBuilder> {
  // fields go here
  String get password;
  String get email;
  String get errorMessage;
  @nullable
  User get user;

  bool get loading;
  bool get isSignedUp => user is User;
  bool get hasError => errorMessage.isNotEmpty;
  LoginState._();

  factory LoginState([updates(LoginStateBuilder b)]) = _$LoginState;

  static LoginState initialState() => LoginState(
        (b) => b
          ..password = ''
          ..email = ''
          ..errorMessage = ''
          ..loading = false
          ..user = null,
      );

  String toJson() {
    return json.encode(serializers.serializeWith(LoginState.serializer, this));
  }

  static LoginState fromJson(String jsonString) {
    return serializers.deserializeWith(LoginState.serializer, json.decode(jsonString));
  }

  static Serializer<LoginState> get serializer => _$loginStateSerializer;
}
