part of 'mark_attendance_bloc.dart';

abstract class MarkAttendanceState extends Equatable {
  const MarkAttendanceState();
  @override
  List<Object> get props => [];
}

class MarkAttendanceInitial extends MarkAttendanceState {}

class MarkAttendanceLoading extends MarkAttendanceState {}

class MarkAttendanceSuccess extends MarkAttendanceState {}

class MarkAttendanceError extends MarkAttendanceState {
  const MarkAttendanceError(this.errorMessage);
  final String errorMessage;
}
