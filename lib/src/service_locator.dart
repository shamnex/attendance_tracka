import 'package:attendance_tracka/flavor/flavor.dart';
import 'package:attendance_tracka/src/core/blocs/bloc_delegate.dart';
import 'package:attendance_tracka/src/core/blocs/hydrated_storage.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/auth/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'core/network/http_client.dart';
import 'core/network/token_manager.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/home/screens/mark_attendance/mark_attendance_repository.dart';

final sl = GetIt.instance..allowReassignment = true;

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
  //! GLOBAL REPOSITORIES STUFFS
  sl.registerLazySingleton<AuthRepository>(() {
    switch (flavor) {
      case Flavor.development:
        return DevAuthRepositoryImpl(sl(), sl());
      case Flavor.mock:
        return MockAuthRepositoryImpl(sl());
      default:
        return AuthRepositoryImpl(sl(), sl());
    }
  });
  sl.registerLazySingleton<MarkAttendanceRepository>(() {
    switch (flavor) {
      case Flavor.development:
        return DevMarkAttendanceRepositoryImpl(sl());
      case Flavor.mock:
        return MockMarkAttendanceRepositoryImpl();
      default:
        return MarkAttendanceRepositoryImpl(sl());
    }
  });
  //! GLOBAL STATE STUFFS
  sl.registerLazySingleton<AppBloc>(() => AppBloc(flavor));
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc(sl(), sl()));
}
