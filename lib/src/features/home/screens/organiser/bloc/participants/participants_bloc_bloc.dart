import 'dart:async';

import 'package:attendance_tracka/src/core/network/http_error_helper.dart';
import 'package:attendance_tracka/src/features/app/model/meetup_model.dart';
import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'participants_bloc_event.dart';
import 'participants_bloc_state.dart';

import '../../organizer_repository.dart';

class ParticipantsBloc extends HydratedBloc<ParticipantsEvent, ParticipantsState> with DioErrorHelper {
  ParticipantsBloc(this.repo, this.organizer);
  final OrganizerRepository repo;
  final User organizer;
  @override
  ParticipantsState get initialState => super.initialState ?? ParticipantsState.initialState();

  @override
  Stream<ParticipantsState> mapEventToState(
    ParticipantsEvent event,
  ) async* {
    try {
      if (event is GetParticipants) {
        yield state.rebuild(
          (s) => s
            ..loading = true
            ..errorMessage = '',
        );
        final List<MeetUp> meetup = await repo.getMeetupRecords(apiURL: event.apiURL);
        if (state.hasMeetup) {
          yield state.clear();
        }
        yield state.rebuild((e) => e
          ..meetup.addAll(meetup)
          ..errorMessage = '');
        yield state.rebuild((e) => e..loading = false);
      }
    } on DioError catch (error) {
      yield state.rebuild((e) => e
        ..loading = false
        ..errorMessage = handleDioError(error));
    } catch (s) {
      yield state.rebuild((s) => s
        ..loading = false
        ..errorMessage = 'Somthing went wrong');
      //! CRASH APP
    }

    // TODO: Add Logic
  }

  @override
  fromJson(Map<String, dynamic> json) {
    try {
      return ParticipantsState.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(state) {
    try {
      return state.hasMeetup && !state.loading ? state.toJson() : null;
    } catch (e) {
      return null;
    }
  }
}
