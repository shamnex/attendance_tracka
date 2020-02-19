part of 'mark_attendance_bloc.dart';

abstract class MarkAttendanceEvent extends Equatable {
  const MarkAttendanceEvent();
  @override
  List<Object> get props => [];
}

class AttendanceMarked extends MarkAttendanceEvent {
  final String email;
  final String apiURL;
  final int interation;
  AttendanceMarked({this.email, this.apiURL, this.interation})
      : assert(email != null),
        assert(apiURL != null),
        assert(interation != null);
}
