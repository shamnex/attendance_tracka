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
          return MockOrganizerRepositoryImpl(sl());
        case Flavor.production:
          return OrganizerRepositoryImpl(sl(), sl());
      }
    });
    sl.registerLazySingleton<OrganizerScreenBloc>(() => OrganizerScreenBloc(sl()));
  }

  static dispose() async {
    sl.unregister<OrganizerRepository>();
    sl.unregister<OrganizerScreenBloc>();
  }
}
