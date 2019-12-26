import 'package:attendance_tracka/src/features/app/app_state.dart';
import 'package:attendance_tracka/src/flavor.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rxdart/rxdart.dart' show Observable;
import 'app_event.dart';

class AppBloc extends HydratedBloc<AppEvent, AppState> {
  AppBloc(Flavor flavor) : _flavor = flavor;

  @override
  Stream<AppState> transformEvents(
    Stream<AppEvent> events,
    Stream<AppState> Function(AppEvent event) next,
  ) {
    return super.transformEvents((events as Observable<AppEvent>).debounceTime(Duration(milliseconds: 300)), next);
  }

  Flavor _flavor;
  @override
  get initialState => super.initialState?.copyWith(loading: false, flavor: _flavor) ?? AppState(flavor: _flavor);

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppModeChanged) {
      yield state.copyWith(mode: event.mode);
    }
    if (event is ThemeChanged) {
      yield state.copyWith(theme: event.theme);
    }
    if (event is HasCompletedWalkThrough) {
      yield state.copyWith(hasCompletedWalkThrough: true);
    }
    if (event is HasOnboarded) {
      yield state.copyWith(hasOnboarded: true);
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
