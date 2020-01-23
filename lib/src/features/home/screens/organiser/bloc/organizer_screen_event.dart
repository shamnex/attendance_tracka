import 'package:equatable/equatable.dart';

abstract class OrganizerScreenEvent extends Equatable {
  const OrganizerScreenEvent();
  @override
  List<Object> get props => [];
}

class AddVolunteers extends OrganizerScreenEvent {
  final String email;
  AddVolunteers(this.email);
  @override
  List<Object> get props => [email];
}
