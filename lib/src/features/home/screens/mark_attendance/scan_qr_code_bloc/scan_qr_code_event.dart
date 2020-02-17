part of 'scan_qr_code_bloc.dart';

abstract class ScanQRCodeEvent extends Equatable {
  const ScanQRCodeEvent();
  @override
  List<Object> get props => [];
}

class ResetScanner extends ScanQRCodeEvent {}

class OnCodeScanned extends ScanQRCodeEvent {
  final Barcode data;
  OnCodeScanned(this.data);
  @override
  List<Object> get props => [data.rawValue];
}
