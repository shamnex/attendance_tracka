import 'package:equatable/equatable.dart';

abstract class GetApiUrlState extends Equatable {
  const GetApiUrlState();
  @override
  List<Object> get props => [];
}

class InitialState extends GetApiUrlState {}

class LoadingState extends GetApiUrlState {}

class ErrorState extends GetApiUrlState {
  final String error;
  ErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class SuccessState extends GetApiUrlState {
  final String apiURL;
  SuccessState(this.apiURL);
  @override
  List<Object> get props => [apiURL];

  @override
  String toString() {
    return 'apiURL is $apiURL';
  }
}
