import 'package:equatable/equatable.dart';

abstract class ParticipantsEvent extends Equatable {
  const ParticipantsEvent();
  List<Object> get props => [];
}

class GetParticipants extends ParticipantsEvent {
  final String apiURL;

  GetParticipants(this.apiURL);
}
