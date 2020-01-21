import 'package:equatable/equatable.dart';

abstract class GetApiUrlEvent extends Equatable {
  @override
  List<Object> get props => [];
  const GetApiUrlEvent();
}

class GetOrganizationApiUrl extends GetApiUrlEvent {
  final String organisationUsername;
  GetOrganizationApiUrl(this.organisationUsername);

  @override
  List<Object> get props => [organisationUsername];
}
