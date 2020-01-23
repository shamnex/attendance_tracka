import 'package:attendance_tracka/src/core/network/http_client.dart';
import 'package:attendance_tracka/src/core/network/token_manager.dart';
import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:attendance_tracka/src/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:dio/dio.dart';

enum ActionRequired { createorg, signinorg }

abstract class AuthRepository with TokenManager {
  Future<User> signup({
    String email,
    String password,
    String organization,
    UserType userType,
    String organizationUserName,
    String apiURL,
  });
  Future<User> login({String email, String password, UserType userType});
  Future<void> signOut();
  Future<String> getOrganisationABB(String organizationUserName);
}

class AuthRepositoryImpl extends TokenManagerImpl implements AuthRepository {
  AuthRepositoryImpl(HiveInterface hive, AppHTTPClient client)
      : _client = client,
        super(hive);

  final AppHTTPClient _client;

  Future<User> login({String email, String password, UserType userType}) {
    return null;
  }

  Future<User> signup({
    String email,
    String password,
    String organization,
    UserType userType,
    String organizationUserName,
    String apiURL,
  }) {
    return null;
  }

  Future<void> signOut() async {
    return await deleteToken();
  }

  @override
  Future<String> getOrganisationABB(String organizationUserName) {
    // TODO: implement getOrganisationABB
    return null;
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

  Future<User> signup({
    String email,
    String password,
    String organization,
    UserType userType,
    String organizationUserName,
    String apiURL,
  }) async {
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

  @override
  Future<String> getOrganisationABB(String organizationUserName) {
    return null;
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
    assert(password != null);
    assert(email != null);
    assert(userType != null);
    try {
      final url = 'actionreq=signinorg&adminemail=$email&password=$password';
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

  Future<User> signup({
    @required String email,
    @required String password,
    @required String organization,
    @required UserType userType,
    @required String organizationUserName,
    @required String apiURL,
  }) async {
    assert(email != null);
    assert(password != null);
    assert(organization != null);
    assert(userType != null);
    assert(organizationUserName != null);
    assert(apiURL != null);
    try {
      String url;
      switch (userType) {
        case UserType.organizer:
          url =
              'actionreq=createorg&orgname=$organization&adminemail=$email&password=$password&apiurl=$apiURL&orgabb=$organizationUserName';
          break;
        case UserType.volunteer:
          url = '$apiURL?actionreq=signin&useremail=$email&password=$password';
          break;
      }
      final res = await _client.get(url, useBaseURL: userType == UserType.organizer);

      if (res.data["status"] == "success") {
        var userJson = res.data['description'];
        return User.fromJson(userJson).rebuild((b) => b..email = email);
      } else {
        throw DioError(
            type: DioErrorType.RESPONSE,
            response: Response(
              data: {'message': res.data['description']},
            ));
      }
    } on DioError catch (_) {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    return await deleteToken();
  }

  @override
  Future<String> getOrganisationABB(String organizationUserName) async {
    try {
      final url = 'actionreq=getorgabbrv&orgabb=$organizationUserName';
      final res = await _client.get(url);

      if (res.data["status"] == "success") {
        var url = res.data['description'];
        return url['API'];
      } else {
        throw DioError(
            type: DioErrorType.RESPONSE,
            response: Response(
              data: {'message': res.data['description']},
            ));
      }
    } on DioError catch (_) {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }
}
