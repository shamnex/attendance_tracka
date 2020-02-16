import 'package:attendance_tracka/flavor/flavor.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import '../../../../service_locator.dart';
import 'add_volunteers/bloc/bloc.dart';
import 'bloc/bloc.dart';
import 'bloc/tab/organiser_screen_tab_bloc.dart';
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
    sl.registerLazySingleton<OrganizerBloc>(() => OrganizerBloc(sl(), sl()));
    sl.registerLazySingleton<AddVolunteersBloc>(() => AddVolunteersBloc(sl(), sl.get<AppBloc>().state.currentUser));
    sl.registerLazySingleton<OrganiserScreenTabBloc>(() => OrganiserScreenTabBloc());
  }

  static dispose() {
    sl.unregister<OrganizerRepository>(disposingFunction: (_) => {});
    sl.unregister<OrganizerBloc>(disposingFunction: (_) {});
    sl.unregister<OrganiserScreenTabBloc>(disposingFunction: (_) {});
  }
}
