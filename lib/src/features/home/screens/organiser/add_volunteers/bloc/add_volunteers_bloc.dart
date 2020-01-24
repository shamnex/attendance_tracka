import 'dart:async';
import 'package:attendance_tracka/src/core/network/http_error_helper.dart';
import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import '../../organizer_repository.dart';
import './bloc.dart';

class AddVolunteersBloc extends Bloc<AddVolunteersEvent, AddVolunteersState> with DioErrorHelper {
  AddVolunteersBloc(this.repo);
  final OrganizerRepository repo;
  @override
  AddVolunteersState get initialState => InitialState();

  @override
  Stream<AddVolunteersState> mapEventToState(
    AddVolunteersEvent event,
  ) async* {
    if (event is Reset) {
      yield InitialState();
    }
    if (event is AddVolunteer) {
      try {
        yield LoadingState();
        await repo.addVonluteers(
          volunteerEmail: event.volunteerEmail,
          password: event.organizerPassword,
          email: event.organizerEmail,
          apiURL: event.apiURL,
        );
        yield AddedState();
      } on DioError catch (e) {
        print(handleDioError(e));
        yield ErrorState(handleDioError(e));
      } catch (e) {
        print(e.toString());
        yield ErrorState('Somthing went wrong');
        //! CRASH APP
      }
    }
  }
}
