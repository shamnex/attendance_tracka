import 'dart:async';
import 'package:attendance_tracka/src/features/home/screens/organiser/add_volunteers/bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:attendance_tracka/src/core/network/http_error_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../organizer_repository.dart';
import './bloc.dart';

class OrganizerBloc extends Bloc<OrganizerEvent, OrganizerState> with DioErrorHelper {
  OrganizerBloc(this.repo, this.addVolunteersBloc) {
    addVolunteersBloc.listen((state) {
      if (state is AddedState) {
        add(VolunteerAdded(state.volunteer));
      }
    });
  }
  final OrganizerRepository repo;
  final AddVolunteersBloc addVolunteersBloc;
  @override
  OrganizerState get initialState => OrganizerState.initialState();

  @override
  Stream<OrganizerState> mapEventToState(
    OrganizerEvent event,
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
