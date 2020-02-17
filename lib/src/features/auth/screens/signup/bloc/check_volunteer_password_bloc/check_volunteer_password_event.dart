import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class CheckVolunteerPasswordBlocEvent extends Equatable {
  @override
  List<Object> get props => [];
  const CheckVolunteerPasswordBlocEvent();
}

class CheckPassword extends CheckVolunteerPasswordBlocEvent {
  final String email;
  final String apiURL;
  CheckPassword({@required this.email, @required this.apiURL})
      : assert(apiURL != null),
        assert(email != null);

  @override
  List<Object> get props => [email, apiURL];
}
