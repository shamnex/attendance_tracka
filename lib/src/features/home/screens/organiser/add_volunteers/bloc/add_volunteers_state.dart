import 'package:equatable/equatable.dart';

abstract class AddVolunteersState extends Equatable {
  const AddVolunteersState();
}

class InitialAddVolunteersState extends AddVolunteersState {
  @override
  List<Object> get props => [];
}
