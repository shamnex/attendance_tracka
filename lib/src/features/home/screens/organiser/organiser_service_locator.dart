import 'package:attendance_tracka/flavor/flavor.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import '../../../../service_locator.dart';
import 'add_volunteers/bloc/bloc.dart';
import 'bloc/participants/participants_bloc_bloc.dart';
import 'bloc/tab/organiser_screen_tab_bloc.dart';
import 'bloc/volunteers/bloc.dart';
import 'organizer_repository.dart';

class OrganiserService {
  static init(Flavor flavor) {
    sl.registerFactory<OrganizerRepository>(() {
      switch (flavor) {
        case Flavor.development:
          return DevOrganizerRepositoryImpl(sl());
        case Flavor.mock:
          return MockOrganizerRepositoryImpl();
        default:
          return OrganizerRepositoryImpl(sl());
      }
    });
    sl.registerSingleton<AddVolunteersBloc>(AddVolunteersBloc(sl(), sl.get<AppBloc>().state.currentUser));
    sl.registerSingleton<VolunteersBloc>(VolunteersBloc(sl(), sl()));
    sl.registerSingleton<ParticipantsBloc>(ParticipantsBloc(sl(), sl.get<AppBloc>().state.currentUser));
    sl.registerSingleton<OrganiserTabBloc>(OrganiserTabBloc());
  }

  static dispose() {
    sl.unregister<OrganizerRepository>(disposingFunction: (_) {});
    sl.unregister<VolunteersBloc>(disposingFunction: (_) {});
    sl.unregister<ParticipantsBloc>(disposingFunction: (_) {});
    sl.unregister<OrganiserTabBloc>(disposingFunction: (_) {});
  }
}
