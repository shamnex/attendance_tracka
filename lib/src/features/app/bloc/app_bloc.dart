import 'package:attendance_tracka/flavor/flavor.dart';


import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'app_event.dart';
import 'app_state.dart';
// import 'package:rxdart/o.dart';

class AppBloc extends HydratedBloc<AppEvent, AppState> {
  AppBloc(Flavor flavor) : _flavor = flavor;

  // @override
  // Stream<AppState> transformEvents(
  //   Stream<AppEvent> events,
  //   Stream<AppState> Function(AppEvent event) next,
  // ) {
  //   return super.transformEvents((events as Observable<AppEvent>).debounceTime(Duration(milliseconds: 300)), next);
  // }

  Flavor _flavor;
  @override
  get initialState => super.initialState ?? AppState.initialState(flavor: _flavor);

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppModeChanged) {
      yield state.rebuild((b) => b..mode = event.mode);
    }
    if (event is ThemeChanged) {
      yield state.rebuild((b) => b..theme = event.theme);
    }
    if (event is HasCompletedWalkThrough) {
      yield state.rebuild((b) => b..hasCompletedWalkThrough = true);
    }
    if (event is HasOnboarded) {
      yield state.rebuild((b) => b..hasOnboarded = true);
    }
  }

  @override
  fromJson(Map<String, dynamic> json) {
    try {
      return AppState.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(state) {
    try {
      return state.toJson();
    } catch (e) {
      return null;
    }
  }
}
