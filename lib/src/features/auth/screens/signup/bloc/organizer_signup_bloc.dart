import 'dart:async';
import 'package:attendance_tracka/src/core/network/http_error_helper.dart';
import 'package:attendance_tracka/src/features/auth/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import './bloc.dart';
import 'package:rxdart/rxdart.dart';

class SignupBloc extends Bloc<OrganizerSignupEvent, OrganizerSignupState> with DioErrorHelper {
  final AuthRepository repo;
  SignupBloc(this.repo);
  @override
  OrganizerSignupState get initialState => OrganizerSignupState.initialState();

  @override
  Stream<OrganizerSignupState> transformEvents(
      Stream<OrganizerSignupEvent> events, Stream<OrganizerSignupState> Function(OrganizerSignupEvent) next) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      next,
    );
  }

  @override
  Stream<OrganizerSignupState> mapEventToState(
    OrganizerSignupEvent event,
  ) async* {
    try {
      if (event is PasswordChanged) {
        yield state.rebuild((b) => b
          ..password = event.password
          ..errorMessage = '');
      }
      if (event is EmailChanged) {
        yield state.rebuild((b) => b
          ..email = event.email
          ..errorMessage = '');
      }
      if (event is OrganisationChanged) {
        yield state.rebuild((b) => b
          ..organisation = event.organisation
          ..errorMessage = '');
      }

      if (event is UserNameChanged) {
        yield state.rebuild((b) => b
          ..organisationUserName = event.userName
          ..errorMessage = '');
      }
      if (event is ApiChanged) {
        yield state.rebuild((b) => b
          ..apiURL = event.apiURL
          ..errorMessage = '');
      }
      if (event is SignUp) {
        yield state.rebuild((b) => b
          ..loading = true
          ..errorMessage = '');
        final user = await repo.organizerSignup(
          email: state.email,
          password: state.password,
          organisation: state.organisation,
          organisationUserName: state.organisationUserName,
          apiURL: state.apiURL,
        );
        yield state.rebuild(
          (b) => b
            ..loading = false
            ..user = user.toBuilder(),
        );
      }
    } on DioError catch (e) {
      yield state.rebuild((b) => b
        ..loading = false
        ..errorMessage = handleDioError(e));
    } catch (e) {
      yield state.rebuild((b) => b..loading = false);
      throw Exception();
    }
  }
}
