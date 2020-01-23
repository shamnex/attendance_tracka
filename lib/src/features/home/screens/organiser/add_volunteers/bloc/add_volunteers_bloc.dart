import 'dart:async';
import 'package:attendance_tracka/src/features/home/screens/organiser/bloc/bloc.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class AddVolunteersBloc extends Bloc<AddVolunteersEvent, AddVolunteersState> {
  AddVolunteersBloc(this.repo);
  final OrganizerScreenBloc repo;
  @override
  AddVolunteersState get initialState => InitialAddVolunteersState();

  @override
  Stream<AddVolunteersState> mapEventToState(
    AddVolunteersEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
