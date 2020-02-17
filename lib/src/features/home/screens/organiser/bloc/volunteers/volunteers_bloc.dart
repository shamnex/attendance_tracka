import 'dart:async';
import 'package:attendance_tracka/src/features/home/screens/organiser/add_volunteers/bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:attendance_tracka/src/core/network/http_error_helper.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../organizer_repository.dart';
import './bloc.dart';

class VolunteersBloc extends HydratedBloc<VolunteersEvent, VolunteersState> with DioErrorHelper {
  VolunteersBloc(this.repo, this.addVolunteersBloc) {
    addVolunteersBloc.listen((state) {
      if (state is AddedState) {
        add(VolunteerAdded(state.volunteer));
      }
    });
  }
  final OrganizerRepository repo;
  final AddVolunteersBloc addVolunteersBloc;
  @override
  VolunteersState get initialState => VolunteersState.initialState();

  @override
  Stream<VolunteersState> mapEventToState(
    VolunteersEvent event,
  ) async* {
    try {
      if (event is GetVolunteers) {
        yield state.rebuild(
          (s) => s
            ..loading = true
            ..errorMessage = '',
        );
        final volunteers = await repo.getVonluteers(event.organizer);
        if (state.hasVolunteers) {
          yield state.clear();
        }
        yield state.rebuild((e) => e
          ..loading = false
          ..errorMessage = ''
          ..volunteers.addAll(volunteers));
      }

      if (event is VolunteerAdded) {
        yield state.rebuild(
          (s) => s
            ..loading = true
            ..errorMessage = '',
        );
        yield state.rebuild((e) => e
          ..loading = false
          ..errorMessage = ''
          ..volunteers.insert(0, event.volunteer));
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
  }

  @override
  fromJson(Map<String, dynamic> json) {
    try {
      return VolunteersState.fromJson(json);
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
