library organizer_screen_state;

import 'package:attendance_tracka/src/core/built_value/serializers.dart';
import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

part 'organizer_screen_state.g.dart';

abstract class OrganizerScreenState implements Built<OrganizerScreenState, OrganizerScreenStateBuilder> {
  static OrganizerScreenState initialState() => OrganizerScreenState((b) => b
    ..loading = false
    ..errorMessage = '');

  @nullable
  BuiltList<User> get participants;
  @nullable
  BuiltList<User> get organizers;
  String get errorMessage;
  bool get loading;
  bool get hasError => errorMessage.isNotEmpty;
  bool get hasOrganizers => organizers != null && organizers.isEmpty;
  bool get hasParticipants => participants != null && participants.isEmpty;
  OrganizerScreenState._();

  factory OrganizerScreenState([updates(OrganizerScreenStateBuilder b)]) = _$OrganizerScreenState;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(OrganizerScreenState.serializer, this);
  }

  static OrganizerScreenState fromJson(Map<String, dynamic> jsonString) {
    return serializers.deserializeWith(OrganizerScreenState.serializer, jsonString);
  }

  static Serializer<OrganizerScreenState> get serializer => _$organizerScreenStateSerializer;
}
