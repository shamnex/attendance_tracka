library meetup_model;

import 'package:attendance_tracka/src/core/built_value/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'meetup_model.g.dart';

abstract class MeetUp implements Built<MeetUp, MeetUpBuilder> {
  MeetUp._();

  BuiltList<String> get attendance;

  int get absent => (attendance.toList()..removeWhere((x) => x.isNotEmpty)).length;
  int get total => attendance.length;
  int get present => (attendance.toList()..removeWhere((x) => x.isEmpty)).length;

  factory MeetUp([updates(MeetUpBuilder b)]) = _$MeetUp;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(MeetUp.serializer, this);
  }

  static MeetUp fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(MeetUp.serializer, json);
  }

  static Serializer<MeetUp> get serializer => _$meetUpSerializer;
}
