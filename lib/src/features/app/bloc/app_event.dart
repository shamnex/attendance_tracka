import 'package:attendance_tracka/src/features/app/model/app_mode.dart';
import 'package:attendance_tracka/src/features/app/model/app_theme.dart';
import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  AppEvent();
  List<Object> get props => [];
}

class HasOnboarded extends AppEvent {
  @override
  List<Object> get props => ['HasOnboarded'];
}

class UserLoggedIn extends AppEvent {
  final User user;
  UserLoggedIn(this.user);
  @override
  List<Object> get props => [user];
}

class UserLoggedOut extends AppEvent {}

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

class IterationChanged extends AppEvent {
  final int iteration;
  IterationChanged(this.iteration);
  @override
  List<Object> get props => [iteration];
}
