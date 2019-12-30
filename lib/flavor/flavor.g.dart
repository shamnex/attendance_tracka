// GENERATED CODE - DO NOT MODIFY BY HAND

part of flavor;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Flavor _$production = const Flavor._('production');
const Flavor _$development = const Flavor._('development');
const Flavor _$mock = const Flavor._('mock');

Flavor _$valueOf(String name) {
  switch (name) {
    case 'production':
      return _$production;
    case 'development':
      return _$development;
    case 'mock':
      return _$mock;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<Flavor> _$values = new BuiltSet<Flavor>(const <Flavor>[
  _$production,
  _$development,
  _$mock,
]);

Serializer<Flavor> _$flavorSerializer = new _$FlavorSerializer();

class _$FlavorSerializer implements PrimitiveSerializer<Flavor> {
  @override
  final Iterable<Type> types = const <Type>[Flavor];
  @override
  final String wireName = 'Flavor';

  @override
  Object serialize(Serializers serializers, Flavor object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  Flavor deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Flavor.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
