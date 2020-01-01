import 'package:attendance_tracka/src/core/blocs/base_bloc/base_bloc_event.dart';
import 'package:attendance_tracka/src/core/blocs/base_bloc/base_bloc_hydrated_bloc.dart';
import 'package:attendance_tracka/src/core/blocs/base_bloc/base_bloc_state.dart';
import 'package:attendance_tracka/src/features/auth/auth_repository.dart';
import 'package:attendance_tracka/src/features/user/model/user_model.dart';
import 'package:dio/dio.dart';

class UserBloc extends BaseBlocHydrated<User> {
  UserBloc({User value, this.repository}) : super(value, (json) => User.fromJson(json));

  final AuthRepository repository;

  @override
  get initialState => super.initialState;

  Stream<BaseBlocState<User>> mapEventToState(
    BaseBlocEvent<User> event,
  ) async* {
    yield* super.mapEventToState(event);

    try {
      if (event is GetUser) {
        yield state.rebuild((b) => b
          ..loading = true
          ..errorMessage = '');
        final user = await repository.login();
        yield state.rebuild((b) => b
          ..value = user
          ..loading = false);
      }

      if (event is RemoveUser) {
        await clear();
        yield state.clear();
      }
    } on DioError catch (e) {
      yield state.rebuild((b) => b..errorMessage = handleNetworkError(e));
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
