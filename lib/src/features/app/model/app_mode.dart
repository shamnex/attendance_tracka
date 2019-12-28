library app_mode;

import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

part 'app_mode.g.dart';

class AppMode extends EnumClass {
  static const AppMode organizer = _$organizer;
  static const AppMode volunteers = _$volunteer;

  const AppMode._(String name) : super(name);

  static BuiltSet<AppMode> get values => _$values;
  static AppMode valueOf(String name) => _$valueOf(name);

  static Serializer<AppMode> get serializer => _$appModeSerializer;
}
