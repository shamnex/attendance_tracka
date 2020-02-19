import 'package:dio/dio.dart';
import 'package:attendance_tracka/src/core/network/http_client.dart';

abstract class MarkAttendanceRepository {
  Future<void> markAttendance({String email, String apiURL, int iteration});
}

class MarkAttendanceRepositoryImpl implements MarkAttendanceRepository {
  MarkAttendanceRepositoryImpl(AppHTTPClient client) : _client = client;
  final AppHTTPClient _client;
  @override
  Future<void> markAttendance({String email, String apiURL, int iteration}) {
    // TODO: implement markAttendance
    return null;
  }
}

class MockMarkAttendanceRepositoryImpl implements MarkAttendanceRepository {
  @override
  Future<void> markAttendance({String email, String apiURL, int iteration}) {
    // TODO: implement markAttendance
    return null;
  }
}

class DevMarkAttendanceRepositoryImpl implements MarkAttendanceRepository {
  DevMarkAttendanceRepositoryImpl(AppHTTPClient client) : _client = client;

  final AppHTTPClient _client;

  @override
  Future<void> markAttendance({String email, String apiURL, int iteration}) async {
    assert(email != null);
    assert(apiURL != null);
    assert(iteration != null);
    try {
      final url = '$apiURL?actionreq=mark&email=$email&iter=$iteration';
      final res = await _client.get(url, useBaseURL: false);
      if (res.data["status"] == "success") {
        return true;
      } else {
        throw DioError(
            type: DioErrorType.RESPONSE,
            response: Response(
              data: {'message': res.data['description'] ?? 'Something went wrong'},
            ));
      }
    } on DioError catch (_) {
      rethrow;
    } catch (_) {
      //!CRASHYLITICS??p
      print(_.toString());
      rethrow;
    }
  }
}
