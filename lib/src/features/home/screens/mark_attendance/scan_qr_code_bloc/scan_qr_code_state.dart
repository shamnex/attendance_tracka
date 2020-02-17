part of 'scan_qr_code_bloc.dart';

abstract class ScanQRCodeState extends Equatable {
  const ScanQRCodeState();
  @override
  List<Object> get props => [];
}

class ScanQRCodeInitial extends ScanQRCodeState {}

class ScanQRCodeLoading extends ScanQRCodeState {}

class ScanQRCodeError extends ScanQRCodeState {
  final String errorMessage;
  ScanQRCodeError(this.errorMessage);
}

class CodeScanned extends ScanQRCodeState {
  final List<Map<String, String>> processedData;
  CodeScanned(this.processedData);
  @override
  List<Object> get props => [processedData];

  String get email {
    return processedData.firstWhere((Map<String, String> map) => map.keys.contains('Email'))['Email'].trim();
  }
}
