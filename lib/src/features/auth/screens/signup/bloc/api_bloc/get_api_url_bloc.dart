import 'dart:async';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:attendance_tracka/src/core/network/http_error_helper.dart';
import 'package:attendance_tracka/src/features/auth/auth_repository.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class GetApiUrlBloc extends Bloc<GetApiUrlEvent, GetApiUrlState> with DioErrorHelper {
  final Map<String, String> _cache = {};
  final AuthRepository repo;
  GetApiUrlBloc(this.repo);
  @override
  GetApiUrlState get initialState => InitialState();

  @override
  Stream<GetApiUrlState> transformEvents(
      Stream<GetApiUrlEvent> events, Stream<GetApiUrlState> Function(GetApiUrlEvent) next) {
    return events.throttleTime(const Duration(milliseconds: 500)).switchMap(next);
  }

  @override
  Stream<GetApiUrlState> mapEventToState(
    GetApiUrlEvent event,
  ) async* {
    try {
      if (event is GetOrganizationApiUrl) {
        if (event.organisationUsername.isEmpty) {
          return;
        }
        yield LoadingState();
        if (_cache.containsKey(event.organisationUsername)) {
          yield SuccessState(_cache[event.organisationUsername]);
        } else {
          final apiURL = await repo.getOrganisationABB(event.organisationUsername);
          _cache[event.organisationUsername] = apiURL;
          yield SuccessState(apiURL);
        }
      }
    } on DioError catch (e) {
      yield ErrorState(handleDioError(e));
      print(handleDioError(e));
    } catch (e) {
      //!CRASHYLITICS??
      yield ErrorState('Something went wrong');
      print(e.toString());
      throw Exception();
    }
  }
}
