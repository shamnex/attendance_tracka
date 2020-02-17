library participants_state;

import 'dart:convert';

import 'package:attendance_tracka/src/core/built_value/serializers.dart';
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
  bool get loading;
  bool get hasError => errorMessage.isNotEmpty;
  ParticipantsState._();

  factory ParticipantsState([updates(ParticipantsStateBuilder b)]) = _$ParticipantsState;

  String toJson() {
    return json.encode(serializers.serializeWith(ParticipantsState.serializer, this));
  }

  static ParticipantsState fromJson(String jsonString) {
    return serializers.deserializeWith(ParticipantsState.serializer, json.decode(jsonString));
  }

  static Serializer<ParticipantsState> get serializer => _$participantsStateSerializer;
}
