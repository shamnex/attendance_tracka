import 'package:equatable/equatable.dart';

abstract class GetApiUrlEvent extends Equatable {
  @override
  List<Object> get props => [];
  const GetApiUrlEvent();
}

class GetOrganisationApiUrl extends GetApiUrlEvent {
  final String organisationUsername;
  GetOrganisationApiUrl(this.organisationUsername);

  @override
  List<Object> get props => [organisationUsername];
}
