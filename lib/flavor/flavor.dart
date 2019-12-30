library flavor;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'flavor.g.dart';

class Flavor extends EnumClass {
  static const Flavor production = _$production;
  static const Flavor development = _$development;
  static const Flavor mock = _$mock;

  const Flavor._(String name) : super(name);

  static BuiltSet<Flavor> get values => _$values;
  static Flavor valueOf(String name) => _$valueOf(name);
  static Serializer<Flavor> get serializer => _$flavorSerializer;
}
