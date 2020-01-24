import 'package:attendance_tracka/flavor/flavor.dart';
import '../../../../service_locator.dart';
import 'bloc/bloc.dart';
import 'organizer_repository.dart';

class OrganiserService {
  static init(Flavor flavor) {
    //! GLOBAL REPOSITORIES STUFFS
    sl.registerLazySingleton<OrganizerRepository>(() {
      switch (flavor) {
        case Flavor.development:
          return DevOrganizerRepositoryImpl(sl(), sl());
        case Flavor.mock:
          return MockOrganizerRepositoryImpl();
        case Flavor.production:
          return OrganizerRepositoryImpl(
            sl(),
          );
      }
    });
    sl.registerLazySingleton<OrganizerBloc>(() => OrganizerBloc(sl()));
  }

  static dispose() async {
    sl.unregister<OrganizerRepository>();
    sl.unregister<OrganizerBloc>();
  }
}
