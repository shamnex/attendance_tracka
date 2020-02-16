import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class OrganizerEvent extends Equatable {
  const OrganizerEvent();
  @override
  List<Object> get props => [];
}

class GetVolunteers extends OrganizerEvent {
  final User organizer;
  final bool refresh;
  GetVolunteers(this.organizer, {this.refresh = false});
  @override
  List<Object> get props => [organizer];
}

class VolunteerAdded extends OrganizerEvent {
  final User volunteer;
  VolunteerAdded(this.volunteer);
  @override
  List<Object> get props => [volunteer];
}
