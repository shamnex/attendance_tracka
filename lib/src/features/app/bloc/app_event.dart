import 'package:attendance_tracka/src/features/app/model/app_mode.dart';
import 'package:attendance_tracka/src/features/app/model/app_theme.dart';
import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  AppEvent();
}

class HasOnboarded extends AppEvent {
  @override
  List<Object> get props => ['HasOnboarded'];
}

class HasCompletedWalkThrough extends AppEvent {
  @override
  List<Object> get props => ['HasCompletedWalkThrough'];
}

class ThemeChanged extends AppEvent {
  ThemeChanged({this.theme});
  final AppTheme theme;
  @override
  List<Object> get props => [theme];
}

class AppModeChanged extends AppEvent {
  final AppMode mode;
  AppModeChanged({this.mode});
  @override
  List<Object> get props => [mode];
}
