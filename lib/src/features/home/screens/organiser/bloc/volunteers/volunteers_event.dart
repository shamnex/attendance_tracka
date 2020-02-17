import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class VolunteersEvent extends Equatable {
  const VolunteersEvent();
  @override
  List<Object> get props => [];
}

class GetVolunteers extends VolunteersEvent {
  final User organizer;
  final bool refresh;
  GetVolunteers(this.organizer, {this.refresh = false});
  @override
  List<Object> get props => [organizer];
}

class VolunteerAdded extends VolunteersEvent {
  final User volunteer;
  VolunteerAdded(this.volunteer);
  @override
  List<Object> get props => [volunteer];
}
