import 'package:attendance_tracka/src/core/network/http_client.dart';
import 'package:attendance_tracka/src/features/user/model/user_model.dart';


abstract class UserRepository {
  Future<User> signup();
  Future<User> login();
}

class UserRepositoryImpl implements UserRepository {
  final AppHTTPClient _httpClient;
  UserRepositoryImpl(AppHTTPClient httpClient) : _httpClient = httpClient;

  Future<User> login({String email, String password}) {
    return null;
  }

  Future<User> signup() {
    return null;
  }
}
