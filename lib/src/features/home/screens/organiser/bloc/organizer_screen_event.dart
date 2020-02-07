import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class OrganizerEvent extends Equatable {
  const OrganizerEvent();
  @override
  List<Object> get props => [];
}

class GetVolunteers extends OrganizerEvent {
  final User organizer;
  GetVolunteers(this.organizer);
  @override
  List<Object> get props => [organizer];
}
