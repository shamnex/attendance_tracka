import 'package:built_value/built_value.dart';

abstract class BaseModel {
  @nullable
  String get id;
  toJson();
}
