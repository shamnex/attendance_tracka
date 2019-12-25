import 'package:attendance_tracka/src/blocs/auth/bloc/auth_bloc.dart';
import 'package:attendance_tracka/src/blocs/hydrated_storage.dart';
import 'package:attendance_tracka/src/features/auth/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'blocs/app/app_bloc.dart';
import 'blocs/bloc_delegate.dart';
import 'blocs/user/bloc/user_bloc.dart';
import 'core/network/http_client.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'flavor.dart';

final sl = GetIt.instance;

Future<void> init(Flavor flavor) async {
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  //!!APP GLOBAL STATE
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc(sl()));
  sl.registerLazySingleton<AppBloc>(() => AppBloc(flavor));
  sl.registerLazySingleton<UserBloc>(() => UserBloc());
  //! LOCAL STORAGE STUFFS
  sl.registerLazySingleton<HydratedBlocDelegate>(() => AppBlocDelegate(sl()));
  final storage = await AppHydratedStorageImpl.getInstance();
  sl.registerLazySingleton<HydratedStorage>(() => storage);
  //! MAIN STUFFS
  sl.registerLazySingleton<HTTPClient>(() => AppHTTPClient(flavor, client: sl(), tokenManager: sl()));
  //! EXTERNAL DEPENDENCIES STUFF
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Hive.init(appDocumentDir.path));
}
