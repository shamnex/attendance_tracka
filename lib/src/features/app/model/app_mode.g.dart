// GENERATED CODE - DO NOT MODIFY BY HAND

part of app_mode;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AppMode _$organizer = const AppMode._('organizer');
const AppMode _$volunteer = const AppMode._('volunteer');

AppMode _$valueOf(String name) {
  switch (name) {
    case 'organizer':
      return _$organizer;
    case 'volunteer':
      return _$volunteer;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<AppMode> _$values = new BuiltSet<AppMode>(const <AppMode>[
  _$organizer,
  _$volunteer,
]);

Serializer<AppMode> _$appModeSerializer = new _$AppModeSerializer();

class _$AppModeSerializer implements PrimitiveSerializer<AppMode> {
  @override
  final Iterable<Type> types = const <Type>[AppMode];
  @override
  final String wireName = 'AppMode';

  @override
  Object serialize(Serializers serializers, AppMode object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  AppMode deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AppMode.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
