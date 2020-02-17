import 'dart:async';

import 'package:attendance_tracka/src/core/network/http_error_helper.dart';
import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'participants_bloc_event.dart';
import 'participants_bloc_state.dart';

import '../../organizer_repository.dart';

class ParticipantsBloc extends Bloc<ParticipantsEvent, ParticipantsState> with DioErrorHelper {
  ParticipantsBloc(this.repo, this.organizer);
  final OrganizerRepository repo;
  final User organizer;
  @override
  ParticipantsState get initialState => ParticipantsState.initialState();

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
        await repo.getParticipants(apiURL: event.apiURL);

        yield state.rebuild((e) => e
          ..loading = false
          ..errorMessage = '');
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
}
