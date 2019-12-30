import 'package:connectivity/connectivity.dart';
import 'package:rxdart/rxdart.dart';

enum ConnectivityStatus { WiFi, Cellular, Offline }

class ConnectivityService {
  final _connectivityStatus = BehaviorSubject<ConnectivityStatus>();

  Stream<ConnectivityStatus> get onConnectivityChanged => _connectivityStatus.stream;

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _connectivityStatus.add(_getStatusFromResult(result));
    });
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }
}
