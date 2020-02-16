library organizer_screen_state;

import 'package:attendance_tracka/src/core/built_value/serializers.dart';
import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

part 'organizer_screen_state.g.dart';

abstract class OrganizerState implements Built<OrganizerState, OrganizerStateBuilder> {
  static OrganizerState initialState() => OrganizerState((s) => s
    ..loading = false
    ..errorMessage = '');

  @nullable
  BuiltList<User> get volunteers;
  String get errorMessage;
  bool get loading;
  bool get hasError => errorMessage.isNotEmpty;
  bool get hasVolunteers => volunteers != null && volunteers.isNotEmpty;
  OrganizerState._();

  OrganizerState clear() => rebuild((b) => b..volunteers.clear());

  factory OrganizerState([updates(OrganizerStateBuilder b)]) = _$OrganizerState;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(OrganizerState.serializer, this);
  }

  static OrganizerState fromJson(Map<String, dynamic> jsonString) {
    return serializers.deserializeWith(OrganizerState.serializer, jsonString);
  }

  static Serializer<OrganizerState> get serializer => _$organizerStateSerializer;
}
