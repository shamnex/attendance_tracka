import 'package:attendance_tracka/src/core/blocs/bloc_delegate.dart';
import 'package:attendance_tracka/src/core/blocs/hydrated_storage.dart';
import 'package:attendance_tracka/src/features/auth/auth_repository.dart';
import 'package:attendance_tracka/src/features/user/resources/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'blocs/app/app_bloc.dart';
import 'core/network/http_client.dart';
import 'core/network/token_manager.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/user/bloc/bloc.dart';
import 'flavor.dart';

final sl = GetIt.instance;

Future<void> init(Flavor flavor) async {
  //! EXTERNAL DEPENDENCIES STUFF
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  sl.registerLazySingleton<HiveInterface>(() => Hive..init(appDocumentDir.path));
  sl.registerLazySingleton(() => Dio());

  //!CORE STUFFS
  sl.registerLazySingleton<TokenManager>(() => TokenManagerImpl(sl()));
  sl.registerLazySingleton<AppHTTPClient>(() => AppHTTPClientImpl(flavor, client: sl(), tokenManager: sl()));

  //! LOCAL STORAGE STUFFS
  sl.registerLazySingleton<HydratedBlocDelegate>(() => AppBlocDelegate(sl()));
  final storage = await AppHydratedStorageImpl.getInstance(sl());
  sl.registerLazySingleton<HydratedStorage>(() => storage);

  //! GLOBAL STATE REPOSITORIES
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));
  //!!APP GLOBAL STATE
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc(sl()));
  sl.registerLazySingleton<AppBloc>(() => AppBloc(flavor));
  sl.registerLazySingleton<UserBloc>(() => UserBloc(value: null, repository: sl()));
}
