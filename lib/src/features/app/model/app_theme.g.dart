// GENERATED CODE - DO NOT MODIFY BY HAND

part of app_theme;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AppTheme _$OrangeLight = const AppTheme._('OrangeLight');
const AppTheme _$OrangeDark = const AppTheme._('OrangeDark');

AppTheme _$valueOf(String name) {
  switch (name) {
    case 'OrangeLight':
      return _$OrangeLight;
    case 'OrangeDark':
      return _$OrangeDark;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<AppTheme> _$values = new BuiltSet<AppTheme>(const <AppTheme>[
  _$OrangeLight,
  _$OrangeDark,
]);

Serializer<AppTheme> _$appThemeSerializer = new _$AppThemeSerializer();

class _$AppThemeSerializer implements PrimitiveSerializer<AppTheme> {
  @override
  final Iterable<Type> types = const <Type>[AppTheme];
  @override
  final String wireName = 'AppTheme';

  @override
  Object serialize(Serializers serializers, AppTheme object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  AppTheme deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AppTheme.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
