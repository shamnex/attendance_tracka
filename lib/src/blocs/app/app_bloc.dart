import 'package:attendance_tracka/src/blocs/app/model/app_mode.dart';
import 'package:attendance_tracka/src/flavor.dart';
import 'package:equatable/equatable.dart';
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
  get initialState => super.initialState?.copyWith(loading: false) ?? AppState(flavor: _flavor);

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    yield state.copyWith(loading: true);
    yield state.copyWith(
        isFirstTime: event.isFirstTime,
        hasOnboarded: event.hasOnboarded,
        loading: false,
        mode: event.mode,
        hasCompletedWalkThrough: event.hasCompletedWalkThrough);
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

class AppEvent extends Equatable {
  final bool hasOnboarded;
  final bool loading;
  final bool isFirstTime;
  final bool hasCompletedWalkThrough;
  final Flavor flavor;
  final AppMode mode;
  AppEvent({
    this.hasOnboarded,
    this.loading,
    this.isFirstTime,
    this.mode,
    this.hasCompletedWalkThrough,
    this.flavor,
  });

  @override
  List<Object> get props => [
        hasOnboarded,
        loading,
        isFirstTime,
        flavor,
        hasCompletedWalkThrough,
      ];
}
