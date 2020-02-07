import 'package:attendance_tracka/flavor/flavor.dart';
import '../../../../service_locator.dart';
import 'bloc/bloc.dart';
import 'organizer_repository.dart';

class OrganiserService {
  static init(Flavor flavor) {
    sl.registerFactory<OrganizerRepository>(() {
      switch (flavor) {
        case Flavor.development:
          return DevOrganizerRepositoryImpl(sl(), sl());
        case Flavor.mock:
          return MockOrganizerRepositoryImpl();
        default:
          return OrganizerRepositoryImpl(sl());
      }
    });
    sl.registerLazySingleton<OrganizerBloc>(() => OrganizerBloc(sl()));
  }

  static dispose() {
    sl.unregister<OrganizerRepository>(disposingFunction: (res) => {});
    sl.unregister<OrganizerBloc>(disposingFunction: (_) {});
  }
}
