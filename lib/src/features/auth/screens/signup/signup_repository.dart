import 'package:attendance_tracka/src/core/network/http_client.dart';
import 'package:attendance_tracka/src/features/user/model/user_model.dart';

abstract class SignupRepository {
  Future<User> signup();
}

class SignupRepositoryImpl implements SignupRepository {
  SignupRepositoryImpl(AppHTTPClient client) : _client = client;
  final AppHTTPClient _client;
  @override
  Future<User> signup() {
    return null;
  }
}
