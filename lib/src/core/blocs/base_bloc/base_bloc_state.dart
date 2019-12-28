library base_bloc_state;

import 'package:attendance_tracka/src/core/built_value/serializers.dart';
import 'package:attendance_tracka/src/core/model/base_model.dart';
import 'dart:convert';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_bloc_state.g.dart';

abstract class BaseBlocState<T extends BaseModel> implements Built<BaseBlocState<T>, BaseBlocStateBuilder<T>> {
  bool get loading;
  bool get isDummy;
  String get errorMessage;
  @nullable
  T get value;

  BaseBlocState._();

  factory BaseBlocState([updates(BaseBlocStateBuilder<T> b)]) = _$BaseBlocState<T>;

  String toJson() {
    return json.encode(serializers.serializeWith(BaseBlocState.serializer, this));
  }

  bool get hasError => errorMessage.isNotEmpty;
  bool get hasValue => value != null && (value?.id != null ?? false || value?.createdAt != null);

  static BaseBlocState fromJson(String jsonString) {
    return serializers.deserializeWith(BaseBlocState.serializer, json.decode(jsonString));
  }

  BaseBlocState<T> clear() {
    return BaseBlocState<T>(
      (b) => b
        ..loading = false
        ..isDummy = false
        ..errorMessage = ''
        ..value = null,
    );
  }

  static Serializer<BaseBlocState> get serializer => _$baseBlocStateSerializer;
}
