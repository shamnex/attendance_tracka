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

class AddedState extends AddVolunteersState {}
