import 'package:attendance_tracka/src/core/blocs/base_bloc/base_bloc_event.dart';
import 'package:attendance_tracka/src/core/blocs/base_bloc/base_bloc_hydrated_bloc.dart';
import 'package:attendance_tracka/src/core/blocs/base_bloc/base_bloc_state.dart';
import 'package:attendance_tracka/src/model/user_model.dart';
import 'package:dio/dio.dart';

import '../user_repository.dart';

class UserBloc extends BaseBlocHydrated<User> {
  UserBloc({User value, this.repository}) : super(value);

  final UserRepository repository;

  @override
  get initialState => super.initialState;

  Stream<BaseBlocState<User>> mapEventToState(
    BaseBlocEvent<User> event,
  ) async* {
    yield* super.mapEventToState(event);

    try {
      if (event is GetUser) {
        yield state.copyWith(loading: true, errorMessage: '');
        final user = await repository.login();
        yield state.copyWith(value: user, loading: false);
      }

      if (event is RemoveUser) {
        await clear();
        yield state.clear();
      }
    } on DioError catch (e) {
      yield state.copyWith(errorMessage: handleNetworkError(e));
    } catch (e) {
      print(e.toString());
    }
  }
}

class GetUser extends BaseBlocEvent<User> {
  final String token;
  GetUser(this.token);
  @override
  List<Object> get props => [token];
}

class RemoveUser extends BaseBlocEvent<User> {
  @override
  List<Object> get props => [];
}
