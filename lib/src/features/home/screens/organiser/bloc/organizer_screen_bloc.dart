import 'dart:async';
import 'package:dio/dio.dart';
import 'package:attendance_tracka/src/core/network/http_error_helper.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../organizer_repository.dart';
import './bloc.dart';

class OrganizerBloc extends HydratedBloc<OrganizerEvent, OrganizerState> with DioErrorHelper {
  OrganizerBloc(this.repo);
  final OrganizerRepository repo;
  @override
  OrganizerState get initialState => super.initialState ?? OrganizerState.initialState();

  @override
  Stream<OrganizerState> mapEventToState(
    OrganizerEvent event,
  ) async* {
    try {
      if (event is GetVolunteers) {
        yield state.rebuild(
          (e) => e
            ..loading = true
            ..errorMessage = '',
        );
        final volunteers = await repo.getVonluteers(event.organizer);
        yield state.rebuild((e) => e
          ..loading = false
          ..errorMessage = ''
          ..volunteers.addAll(volunteers));
      }
    } on DioError catch (error) {
      yield state.rebuild((e) => e
        ..loading = false
        ..errorMessage = handleDioError(error));
    } catch (e) {
      yield state.rebuild((e) => e
        ..loading = false
        ..errorMessage = 'Somthing went wrong');
      //! CRASH APP
    }
  }

  @override
  fromJson(Map<String, dynamic> json) {
    try {
      return OrganizerState.fromJson(json);
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
