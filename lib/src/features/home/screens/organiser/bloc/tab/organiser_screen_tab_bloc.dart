import 'dart:async';
import 'package:bloc/bloc.dart';
import 'organiser_screen_tab_event.dart';
import 'organizer_screen_tab.dart';

class OrganiserTabBloc extends Bloc<OrganizerScreenTabEvent, OrganizerScreenTab> {
  @override
  OrganizerScreenTab get initialState => OrganizerScreenTab.home;

  @override
  Stream<OrganizerScreenTab> mapEventToState(OrganizerScreenTabEvent event) async* {
    if (event is TabChanged) {
      yield event.tab;
    }
  }
}
