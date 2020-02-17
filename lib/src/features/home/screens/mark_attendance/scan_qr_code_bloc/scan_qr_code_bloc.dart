import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:validators/validators.dart' as validators;

part 'scan_qr_code_event.dart';
part 'scan_qr_code_state.dart';

class ScanQRCodeBloc extends Bloc<ScanQRCodeEvent, ScanQRCodeState> {
  @override
  Stream<ScanQRCodeState> transformEvents(
      Stream<ScanQRCodeEvent> events, Stream<ScanQRCodeState> Function(ScanQRCodeEvent) next) {
    return events.throttleTime(const Duration(milliseconds: 500), trailing: true).switchMap(next);
  }

  @override
  ScanQRCodeState get initialState => ScanQRCodeInitial();

  @override
  Stream<ScanQRCodeState> mapEventToState(
    ScanQRCodeEvent event,
  ) async* {
    if (event is ResetScanner) {
      yield ScanQRCodeInitial();
    }

    if (event is OnCodeScanned) {
      if (state is! ScanQRCodeError) {
        yield ScanQRCodeLoading();
      }
      await Future.delayed(Duration(milliseconds: 1500));
      try {
        final items = event.data.rawValue.split("\n");
        final keys = <String>[];
        var proccessedData = items.map<Map<String, String>>((item) {
          var mapList = item.split(':');
          keys.add(mapList.first);
          return {'${mapList.first}': '${mapList.last}'};
        }).toList();

        final yieldableState = CodeScanned(proccessedData);
        if (keys.contains('Email')) {
          if (validators.isEmail(yieldableState.email)) {
            yield yieldableState;
          } else {
            yield ScanQRCodeError('This participant is not yet registered');
          }
        } else {
          yield ScanQRCodeError('Invalid QRCode');
        }
      } catch (_) {
        yield ScanQRCodeError('Error Processing code');
      }
      //PROCESS DATA HERE OH
    }
    // TODO: Add Logic
  }
}
