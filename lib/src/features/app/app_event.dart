import 'package:equatable/equatable.dart';

import 'model/app_mode.dart';
import 'model/app_theme.dart';
import '../../flavor.dart';

abstract class AppEvent extends Equatable {
  AppEvent();
}

class HasOnboarded extends AppEvent {
  @override
  List<Object> get props => [];
}

class HasCompletedWalkThrough extends AppEvent {
  @override
  List<Object> get props => [];
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
  List<Object> get props => [];
}
