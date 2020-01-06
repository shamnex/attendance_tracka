import 'package:attendance_tracka/src/core/network/http_client.dart';
import 'package:attendance_tracka/src/core/network/token_manager.dart';
import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:attendance_tracka/src/utils/string_utils.dart';
import 'package:hive/hive.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

enum ActionRequired { createorg, signinorg }

abstract class AuthRepository with TokenManager {
  Future<User> signup({String email, String password, String organization, UserType userType, String apiURL});
  Future<User> login({String email, String password, UserType userType});
  Future<void> signOut();
}

class AuthRepositoryImpl extends TokenManagerImpl implements AuthRepository {
  AuthRepositoryImpl(HiveInterface hive, AppHTTPClient client)
      : _client = client,
        super(hive);

  final AppHTTPClient _client;

  Future<User> login({String email, String password, UserType userType}) {
    return null;
  }

  Future<User> signup({String email, String password, String organization, UserType userType, String apiURL}) {
    return null;
  }

  Future<void> signOut() async {
    return await deleteToken();
  }
}

class MockAuthRepositoryImpl extends TokenManagerImpl implements AuthRepository {
  MockAuthRepositoryImpl(HiveInterface hive) : super(hive);

  Future<User> login({String email, String password, UserType userType}) async {
    Future.delayed(Duration(seconds: 2));
    await persistToken(StringUtils.generateRandom());
    return User.fromJson({
      'id': StringUtils.generateRandom(),
      'email': email,
      'type': userType.name,
    });
  }

  Future<User> signup({String email, String password, String organization, UserType userType, String apiURL}) async {
    Future.delayed(Duration(seconds: 2));
    await persistToken(StringUtils.generateRandom());
    return User.fromJson({
      'id': StringUtils.generateRandom(),
      'email': email,
      'organization': organization,
      'type': userType.name,
    });
  }

  Future<void> signOut() async {
    return await deleteToken();
  }
}

class DevAuthRepositoryImpl extends TokenManagerImpl implements AuthRepository {
  DevAuthRepositoryImpl(HiveInterface hive, AppHTTPClient client)
      : _client = client,
        super(hive);

  final AppHTTPClient _client;

  Future<User> login({
    String email,
    String password,
    UserType userType,
  }) async {
    try {
      final url = 'actionreq=signinorg&adminemail=$email&password=$password';
      final res = await _client.get(url);
      var userJson = res.data['description']['description'];
      return User.fromJson(userJson).rebuild((b) => b..email = email);
    } on DioError catch (_) {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  Future<User> signup({
    String email,
    String password,
    String organization,
    UserType userType,
    String organizationUserName,
    String apiURL,
  }) async {
    try {
      final url =
          'actionreq=createorg&orgname=$organization&adminemail=$email&password=$password&apiurl=$apiURL&orgabb=$organizationUserName';
      final res = await _client.get(url);
      var userJson = res.data['description']['description'];
      return User.fromJson(userJson).rebuild((b) => b..email = email);
    } on DioError catch (_) {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    return await deleteToken();
  }
}
