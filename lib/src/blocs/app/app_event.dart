import 'package:attendance_tracka/src/blocs/app/model/app_mode.dart';
import 'package:attendance_tracka/src/flavor.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AppState extends Equatable {
  final bool hasOnboarded;
  final bool loading;
  final Flavor flavor;
  final AppMode mode;
  final bool hasCompletedWalkThrough;

  AppState({
    this.mode = AppMode.organizer,
    this.hasOnboarded = false,
    this.hasCompletedWalkThrough = false,
    this.loading = false,
    this.flavor,
  }) : assert(flavor != null);

  AppState copyWith({
    bool hasOnboarded,
    bool hasCompletedWalkThrough,
    bool loading,
    AppMode mode,
    bool isFirstTime,
  }) {
    return AppState(
      loading: loading ?? this.loading,
      flavor: this.flavor,
      mode: mode ?? this.mode,
      hasOnboarded: hasOnboarded ?? this.hasOnboarded,
      hasCompletedWalkThrough: hasCompletedWalkThrough ?? this.hasCompletedWalkThrough,
    );
  }

  @override
  String toString() => '''

  {
        hasOnboarded: $hasOnboarded,
        loading: $loading,
        flavor: $flavor,
        hasCompletedWalkThrough: $hasCompletedWalkThrough,
  }
  
  ''';

  @override
  List<Object> get props => [
        hasOnboarded,
        hasCompletedWalkThrough,
        loading,
        mode,
        flavor,
      ];

  static AppState fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {}
}
