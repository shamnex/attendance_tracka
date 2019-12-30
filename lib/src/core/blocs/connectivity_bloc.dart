import 'package:attendance_tracka/src/core/network/connectiviy_service.dart';
import 'package:bloc/bloc.dart';

class ConnectivityEvent {
  final ConnectivityStatus status;

  ConnectivityEvent(this.status);
}

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityStatus> {
  ConnectivityBloc(ConnectivityService connectivityService) {
    connectivityService.onConnectivityChanged.listen((status) {
      add(ConnectivityEvent(status));
    });
  }

  @override
  ConnectivityStatus get initialState => ConnectivityStatus.Cellular;

  @override
  Stream<ConnectivityStatus> mapEventToState(ConnectivityEvent event) async* {
    yield event.status;
  }
}
