import 'dart:async';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import './bloc.dart';

class OrganizerScreenBloc extends HydratedBloc<OrganizerScreenEvent, OrganizerScreenState> {
  @override
  OrganizerScreenState get initialState => super.initialState ?? OrganizerScreenState.initialState();

  @override
  Stream<OrganizerScreenState> mapEventToState(
    OrganizerScreenEvent event,
  ) async* {
    // TODO: Add Logic
  }

  @override
  fromJson(Map<String, dynamic> json) {
    try {
      return OrganizerScreenState.fromJson(json);
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
