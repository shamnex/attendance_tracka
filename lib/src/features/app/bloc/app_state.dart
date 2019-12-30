library app_state;

import 'package:attendance_tracka/src/core/built_value/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:attendance_tracka/src/features/app/model/app_mode.dart';
import 'package:attendance_tracka/src/features/app/model/app_theme.dart';
import 'package:attendance_tracka/flavor/flavor.dart';


import 'package:built_value/serializer.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  bool get hasOnboarded;
  bool get loading;
  Flavor get flavor;
  AppMode get mode;
  AppTheme get theme;
  bool get hasCompletedWalkThrough;

  AppState._();

  static AppState initialState({Flavor flavor}) => AppState((b) => b
    ..mode = AppMode.organizer
    ..hasOnboarded = false
    ..hasCompletedWalkThrough = false
    ..loading = false
    ..flavor = flavor
    ..theme = AppTheme.OrangeLight);

  factory AppState([updates(AppStateBuilder b)]) = _$AppState;

  static Serializer<AppState> get serializer => _$appStateSerializer;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(AppState.serializer, this);
  }

  static AppState fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(AppState.serializer, json);
  }
}
