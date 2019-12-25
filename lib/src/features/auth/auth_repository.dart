import 'dart:ffi';

import 'package:attendance_tracka/src/core/network/token_manager.dart';
import 'package:attendance_tracka/src/model/user_model.dart';

abstract class AuthRepository {
  Future<User> login({String email, String password});
  Future<User> signup();
  Future<void> signOut();
  Future<bool> hasToken();
}

class AuthRepositoryImpl implements AuthRepository {
  final TokenManager _tokenManager;
  AuthRepositoryImpl(TokenManager tokenManager) : _tokenManager = tokenManager;
  Future<User> login({String email, String password}) {
    //TODO
    return null;
  }

  Future<User> signup() {
    //TODO
    return null;
  }

  Future<void> signOut() async {
    await _tokenManager.deleteToken();
  }

  Future<bool> hasToken() => _tokenManager.hasToken();
}
