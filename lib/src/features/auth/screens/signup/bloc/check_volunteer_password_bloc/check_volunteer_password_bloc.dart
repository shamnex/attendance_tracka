import 'dart:async';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:attendance_tracka/src/core/network/http_error_helper.dart';
import 'package:attendance_tracka/src/features/auth/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'check_volunteer_password_event.dart';
import 'check_volunteer_password_state.dart';
import 'package:validators/validators.dart' as validators;

class CheckVolunteerPasswordBloc extends Bloc<CheckVolunteerPasswordBlocEvent, CheckVolunteerPasswordState>
    with DioErrorHelper {
  final Map<String, CHVSuccessState> _cache = {};
  final AuthRepository repo;
  CheckVolunteerPasswordBloc(this.repo);

  @override
  CheckVolunteerPasswordState get initialState => CHVInitialState();

  @override
  Stream<CheckVolunteerPasswordState> transformEvents(Stream<CheckVolunteerPasswordBlocEvent> events,
      Stream<CheckVolunteerPasswordState> Function(CheckVolunteerPasswordBlocEvent) next) {
    return events.throttleTime(const Duration(milliseconds: 1000), trailing: true).switchMap(next);
  }

  @override
  Stream<CheckVolunteerPasswordState> mapEventToState(
    CheckVolunteerPasswordBlocEvent event,
  ) async* {
    try {
      if (event is CheckPassword) {
        if (event.email.isEmpty) {
          return;
        }
        yield CHVLoadingState();

        if (!validators.isEmail(event.email)) {
          yield CHVErrorState('Please enter a valid email address');
          return;
        }
        if (_cache.containsKey(event.email)) {
          yield _cache[event.email];
        } else {
          final hasSuccess = await repo.volunteerHasPassword(email: event.email, organisationApiURL: event.apiURL);
          _cache[event.email] = CHVSuccessState(hasSuccess);
          yield CHVSuccessState(hasSuccess);
        }
      }
    } on DioError catch (e) {
      yield CHVErrorState(handleDioError(e));
      print(handleDioError(e));
    } catch (e) {
      //!CRASHYLITICS??
      yield CHVErrorState('Something went wrong');
      print(e.toString());
      throw Exception();
    }
  }
}
