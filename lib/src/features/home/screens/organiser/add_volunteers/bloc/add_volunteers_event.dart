import 'package:equatable/equatable.dart';

abstract class AddVolunteersEvent extends Equatable {
  const AddVolunteersEvent();
  @override
  List<Object> get props => [];
}

class AddVolunteer extends AddVolunteersEvent {
  final String volunteerEmail;

  final String organizerPassword;
  final String apiURL;

  final String organizerEmail;
  AddVolunteer({this.volunteerEmail, this.organizerEmail, this.organizerPassword, this.apiURL});
  @override
  List<Object> get props => [volunteerEmail];
}

class Reset extends AddVolunteersEvent {}
