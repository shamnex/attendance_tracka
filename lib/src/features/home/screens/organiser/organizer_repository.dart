import 'package:attendance_tracka/src/core/network/http_client.dart';
import 'package:attendance_tracka/src/core/network/token_manager.dart';
import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:hive/hive.dart';
import 'package:dio/dio.dart';

enum ActionRequired { createorg, signinorg }

abstract class OrganizerRepository with TokenManager {
  Future<List<User>> getVonluteers();
  Future<User> addVonluteers();
}

class OrganizerRepositoryImpl extends TokenManagerImpl implements OrganizerRepository {
  OrganizerRepositoryImpl(HiveInterface hive, AppHTTPClient client)
      : _client = client,
        super(hive);

  final AppHTTPClient _client;

  @override
  Future<User> addVonluteers() {
    // TODO: implement addVonluteers
    return null;
  }

  @override
  Future<List<User>> getVonluteers() {
    // TODO: implement getVonluteers
    return null;
  }
}

class MockOrganizerRepositoryImpl extends TokenManagerImpl implements OrganizerRepository {
  MockOrganizerRepositoryImpl(HiveInterface hive) : super(hive);

  @override
  Future<User> addVonluteers() {
    // TODO: implement addVonluteers
    return null;
  }

  @override
  Future<List<User>> getVonluteers() {
    // TODO: implement getVonluteers
    return null;
  }
}

class DevOrganizerRepositoryImpl extends TokenManagerImpl implements OrganizerRepository {
  DevOrganizerRepositoryImpl(HiveInterface hive, AppHTTPClient client)
      : _client = client,
        super(hive);

  final AppHTTPClient _client;

  Future<User> addVonluteers({
    String email,
    String password,
    String volunteer_email,
  }) async {
    assert(password != null);
    assert(email != null);
    assert(volunteer_email != null);
    try {
      final url = 'actionreq=request_volunteer&vemail=$volunteer_email&aemail=$email&apassword=$password';
      final res = await _client.get(url);
      if (res.data["status"] == "success") {
        var userJson = res.data['description'];
        return User.fromJson(userJson).rebuild((b) => b..email = email);
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
      print(_.toString());
      rethrow;
    }
  }

  @override
  Future<List<User>> getVonluteers() {
    // TODO: implement getVonluteers
    return null;
  }
}
