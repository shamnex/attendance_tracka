library organizer_screen_state;

import 'package:attendance_tracka/src/core/built_value/serializers.dart';
import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

part 'volunteers_state.g.dart';

abstract class VolunteersState implements Built<VolunteersState, VolunteersStateBuilder> {
  VolunteersState._();

  @nullable
  BuiltList<User> get volunteers;
  String get errorMessage;
  bool get loading;
  bool get hasError => errorMessage.isNotEmpty;
  bool get hasVolunteers => volunteers != null && volunteers.isNotEmpty;
  bool get noRegisteredVolunteers => volunteers != null && volunteers.isEmpty;
  static VolunteersState initialState() => VolunteersState((s) => s
    ..loading = false
    ..errorMessage = '');
  VolunteersState clear() => rebuild((b) => b..volunteers.clear());

  factory VolunteersState([updates(VolunteersStateBuilder b)]) = _$VolunteersState;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(VolunteersState.serializer, this);
  }

  static VolunteersState fromJson(Map<String, dynamic> jsonString) {
    return serializers.deserializeWith(VolunteersState.serializer, jsonString);
  }

  static Serializer<VolunteersState> get serializer => _$volunteersStateSerializer;
}
