library participants_state;

import 'package:attendance_tracka/src/core/built_value/serializers.dart';
import 'package:attendance_tracka/src/features/app/model/meetup_model.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'participants_bloc_state.g.dart';

abstract class ParticipantsState implements Built<ParticipantsState, ParticipantsStateBuilder> {
  static ParticipantsState initialState() => ParticipantsState((s) => s
    ..loading = false
    ..errorMessage = '');

  // fields go here
  String get errorMessage;
  @nullable
  BuiltList<MeetUp> get meetup;
  bool get loading;
  bool get hasMeetup => meetup != null;
  bool get hasError => errorMessage.isNotEmpty;
  ParticipantsState clear() => rebuild((b) => b..meetup.clear());

  ParticipantsState._();

  factory ParticipantsState([updates(ParticipantsStateBuilder b)]) = _$ParticipantsState;
  Map<String, dynamic> toJson() {
    return serializers.serializeWith(ParticipantsState.serializer, this);
  }

  static ParticipantsState fromJson(Map<String, dynamic> jsonString) {
    return serializers.deserializeWith(ParticipantsState.serializer, jsonString);
  }

  static Serializer<ParticipantsState> get serializer => _$participantsStateSerializer;
}
