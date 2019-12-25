import 'package:equatable/equatable.dart';

abstract class BaseModel extends Equatable {
  final String id;
  final DateTime createdAt;
  BaseModel({
    this.id,
    this.createdAt,
  });
  Map<String, dynamic> toJson();
  BaseModel fromJson(Map<String, dynamic> json);
}
