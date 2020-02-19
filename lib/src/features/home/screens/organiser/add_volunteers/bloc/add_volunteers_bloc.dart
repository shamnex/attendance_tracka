import 'dart:async';
import 'package:attendance_tracka/src/core/network/http_error_helper.dart';
import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import '../../organizer_repository.dart';
import './bloc.dart';

class AddVolunteersBloc extends Bloc<AddVolunteersEvent, AddVolunteersState> with DioErrorHelper {
  AddVolunteersBloc(this.repo, this.organizer);
  final OrganizerRepository repo;
  final User organizer;
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
        //TODO when Kenechi returns proper data from the backend
        final addedUser = organizer.rebuild(
          (b) => b
            ..email = event.volunteerEmail
            ..type = UserType.volunteer,
        );
        yield AddedState(addedUser);
      } on DioError catch (e) {
        print(handleDioError(e));
        yield ErrorState(handleDioError(e));
      } catch (e) {
        //!CRASHYLITICS??
        print(e.toString());
        yield ErrorState('Somthing went wrong');
      }
    }
  }
}
