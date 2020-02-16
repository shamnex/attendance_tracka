import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class AddVolunteersState extends Equatable {
  const AddVolunteersState();
  @override
  List<Object> get props => [];
}

class LoadingState extends AddVolunteersState {}

class InitialState extends AddVolunteersState {}

class ErrorState extends AddVolunteersState {
  final String error;
  const ErrorState(this.error);
}

class AddedState extends AddVolunteersState {
  final User volunteer;
  AddedState(this.volunteer);
}
