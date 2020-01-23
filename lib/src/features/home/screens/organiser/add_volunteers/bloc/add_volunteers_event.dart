import 'package:equatable/equatable.dart';

abstract class AddVolunteersEvent extends Equatable {
  const AddVolunteersEvent();
  @override
  List<Object> get props => [];
}

class AddVolunteer extends AddVolunteersEvent {
  final String volunteerEmail;
  AddVolunteer(this.volunteerEmail);
  @override
  List<Object> get props => [volunteerEmail];
}
