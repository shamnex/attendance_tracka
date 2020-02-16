import 'package:equatable/equatable.dart';
import 'organizer_screen_tab.dart';

abstract class OrganizerScreenTabEvent extends Equatable {
  const OrganizerScreenTabEvent();
}

class TabChanged extends OrganizerScreenTabEvent {
  final OrganizerScreenTab tab;

  const TabChanged(this.tab);

  @override
  List<Object> get props => [tab];

  @override
  String toString() => 'TabChanged { tab: $tab }';
}
