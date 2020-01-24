import 'package:equatable/equatable.dart';

abstract class OrganizerEvent extends Equatable {
  const OrganizerEvent();
  @override
  List<Object> get props => [];
}

class GetVolunteers extends OrganizerEvent {
  final String apiURL;
  GetVolunteers(this.apiURL);
  @override
  List<Object> get props => [apiURL];
}
