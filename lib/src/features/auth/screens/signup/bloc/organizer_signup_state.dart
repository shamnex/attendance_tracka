library sign_up_state;

import 'dart:convert';

import 'package:attendance_tracka/src/core/built_value/serializers.dart';
import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
part 'organizer_signup_state.g.dart';

abstract class OrganizerSignupState implements Built<OrganizerSignupState, OrganizerSignupStateBuilder> {
  // fields go here
  // fields go here
  String get organisation;
  String get password;
  String get email;
  String get errorMessage;
  String get apiURL;
  String get organisationUserName;
  @nullable
  User get user;

  bool get loading;
  bool get isSignedUp => user is User;
  bool get hasError => errorMessage.isNotEmpty;
  OrganizerSignupState._();

  factory OrganizerSignupState([updates(OrganizerSignupStateBuilder b)]) = _$OrganizerSignupState;

  String toJson() {
    return json.encode(serializers.serializeWith(OrganizerSignupState.serializer, this));
  }

  static OrganizerSignupState fromJson(String jsonString) {
    return serializers.deserializeWith(OrganizerSignupState.serializer, json.decode(jsonString));
  }

  static Serializer<OrganizerSignupState> get serializer => _$organizerSignupStateSerializer;

  static OrganizerSignupState initialState() => OrganizerSignupState(
        (b) => b
          ..organisation = ''
          ..organisationUserName = ''
          ..password = ''
          ..email = ''
          ..errorMessage = ''
          ..loading = false
          ..apiURL = ''
          ..user = null,
      );
}
