import 'package:equatable/equatable.dart';

abstract class CheckVolunteerPasswordState extends Equatable {
  const CheckVolunteerPasswordState();
  @override
  List<Object> get props => [];
}

class CHVInitialState extends CheckVolunteerPasswordState {}

class CHVLoadingState extends CheckVolunteerPasswordState {}

class CHVErrorState extends CheckVolunteerPasswordState {
  final String error;
  CHVErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class CHVSuccessState extends CheckVolunteerPasswordState {
  final bool haspassword;
  CHVSuccessState(this.haspassword);
  @override
  List<Object> get props => [haspassword];

  @override
  String toString() {
    return 'haspassword is $haspassword';
  }
}
