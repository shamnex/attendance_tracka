part of 'scan_qr_code_bloc.dart';

abstract class ScanQRCodeEvent extends Equatable {
  const ScanQRCodeEvent();
  @override
  List<Object> get props => [];
}

class ResetScanner extends ScanQRCodeEvent {}

class DisableScanner extends ScanQRCodeEvent {
  final String message;
  DisableScanner([this.message]);
  @override
  List<Object> get props => [message];
}

class OnCodeScanned extends ScanQRCodeEvent {
  final Barcode data;
  OnCodeScanned(this.data);
  @override
  List<Object> get props => [data.rawValue];
}
