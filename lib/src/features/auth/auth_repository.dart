import 'package:attendance_tracka/src/core/network/http_client.dart';
import 'package:attendance_tracka/src/core/network/token_manager.dart';
import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:attendance_tracka/src/features/auth/screens/login/model/volunteer_login_success.dart';
import 'package:attendance_tracka/src/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:dio/dio.dart';
import 'package:validators/sanitizers.dart';

enum ActionRequired { createorg, signinorg }

abstract class AuthRepository with TokenManager {
  Future<User> organizerSignup({
    String email,
    String password,
    String organisation,
    String organisationUserName,
    String apiURL,
  });
  Future<User> organizerLogin({
    String email,
    String password,
  });
  Future<void> signOut();
  Future<String> getOrganisationABB(String organisationUserName);
  Future<VolunteerLoginSuccess> volunteerLogin({
    String email,
    String password,
    String apiURL,
    String organisationUserName,
  });
  Future<void> createVolunteerPassword({
    String organisationApiURL,
    String email,
    String password,
  });

  Future<bool> volunteerHasPassword({String email, String organisationApiURL});
}

class AuthRepositoryImpl extends TokenManagerImpl implements AuthRepository {
  AuthRepositoryImpl(HiveInterface hive, AppHTTPClient client)
      : _client = client,
        super(hive);

  final AppHTTPClient _client;

  Future<User> organizerLogin({
    String email,
    String password,
  }) {
    return null;
  }

  Future<User> organizerSignup({
    String email,
    String password,
    String organisation,
    String organisationUserName,
    String apiURL,
  }) {
    return null;
  }

  Future<void> signOut() async {
    return await deleteToken();
  }

  @override
  Future<String> getOrganisationABB(String organisationUserName) {
    // TODO: implement getOrganisationABB
    return null;
  }

  @override
  Future<VolunteerLoginSuccess> volunteerLogin({
    String email,
    String password,
    String apiURL,
    String organisationUserName,
  }) {
    // TODO: implement volunteerLogin
    return null;
  }

  @override
  Future<bool> volunteerHasPassword({String email, String organisationApiURL}) {
    return null;
  }

  @override
  Future<void> createVolunteerPassword({
    String email,
    String password,
    String organisationApiURL,
  }) {
    // TODO: implement createVolunteerPassword
    return null;
  }
}

class MockAuthRepositoryImpl extends TokenManagerImpl implements AuthRepository {
  MockAuthRepositoryImpl(HiveInterface hive) : super(hive);

  Future<User> organizerLogin({
    String email,
    String password,
  }) async {
    Future.delayed(Duration(seconds: 2));
    await persistToken(StringUtils.generateRandom());
    return User.fromJson({
      'id': StringUtils.generateRandom(),
      'email': email,
    });
  }

  Future<User> organizerSignup({
    String email,
    String password,
    String organisation,
    String organisationUserName,
    String apiURL,
  }) async {
    Future.delayed(Duration(seconds: 2));
    await persistToken(StringUtils.generateRandom());
    return User.fromJson({
      'id': StringUtils.generateRandom(),
      'email': email,
      'organisation': organisation,
    });
  }

  Future<void> signOut() async {
    return await deleteToken();
  }

  @override
  Future<String> getOrganisationABB(String organisationUserName) {
    return null;
  }

  @override
  Future<VolunteerLoginSuccess> volunteerLogin({
    String email,
    String password,
    String apiURL,
    String organisationUserName,
  }) {
    // TODO: implement volunteerLogin
    return null;
  }

  @override
  Future<bool> volunteerHasPassword({String email, String organisationApiURL}) {
    // TODO: implement volunteerHasPassword
    return null;
  }

  @override
  Future<void> createVolunteerPassword({String organisationApiURL, String email, String password}) {
    // TODO: implement createVolunteerPassword
    return null;
  }
}

class DevAuthRepositoryImpl extends TokenManagerImpl implements AuthRepository {
  DevAuthRepositoryImpl(HiveInterface hive, AppHTTPClient client)
      : _client = client,
        super(hive);

  final AppHTTPClient _client;

  Future<User> organizerLogin({
    String email,
    String password,
  }) async {
    assert(password != null);
    assert(email != null);
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
      //!CRASHYLITICS??
      print(_.toString());
      rethrow;
    }
  }

  Future<User> organizerSignup({
    @required String email,
    @required String password,
    @required String organisation,
    @required @required String organisationUserName,
    @required String apiURL,
  }) async {
    assert(email != null);
    assert(password != null);
    assert(organisation != null);
    assert(organisationUserName != null);
    assert(apiURL != null);
    try {
      final url =
          'actionreq=createorg&orgname=$organisation&adminemail=$email&password=$password&apiurl=$apiURL&orgabb=$organisationUserName';

      final res = await _client.get(url);

      if (res.data["status"] == "success") {
        var userJson = res.data['description'];
        return User.fromJson(userJson).rebuild(
          (b) => b..email = email,
        );
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
  Future<String> getOrganisationABB(String organisationUserName) async {
    try {
      final url = 'actionreq=getorgabbrv&orgabb=$organisationUserName';
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

  @override
  Future<VolunteerLoginSuccess> volunteerLogin({
    String email,
    String password,
    String apiURL,
    String organisationUserName,
  }) async {
    assert(email != null);
    assert(password != null);
    assert(apiURL != null);
    assert(organisationUserName != null);
    final url = '$apiURL?actionreq=signin&email=$email&password=$password';
    final res = await _client.get(url, useBaseURL: false);

    if (res.data["status"] == "success") {
      var resJson = res.data['description'];
      resJson['ORGANISATIONN_ABB'] = organisationUserName;
      resJson['API_URL'] = apiURL;
      final int iter = resJson['ITER_NO'];
      final user = User.fromJson(resJson).rebuild((b) => b..email = email);
      return VolunteerLoginSuccess(user: user, iteration: iter);
    } else {
      throw DioError(
          type: DioErrorType.RESPONSE,
          response: Response(
            data: {'message': res.data['description']},
          ));
    }
  }

  @override
  Future<bool> volunteerHasPassword({String email, String organisationApiURL}) async {
    try {
      final url = '$organisationApiURL?actionreq=check_email&email=$email';
      final res = await _client.get(url, useBaseURL: false);

      if (res.data["status"] == "success") {
        return toBoolean(res.data['description'].toString().toLowerCase());
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

  @override
  Future createVolunteerPassword({String organisationApiURL, String email, String password}) async {
    final url = '$organisationApiURL?actionreq=create_user_pass&vemail=$email&vpassword=$password';
    final res = await _client.get(url, useBaseURL: false);
    if (res.data["status"] == "success") {
      return;
    } else {
      throw DioError(
          type: DioErrorType.RESPONSE,
          response: Response(
            data: {'message': res.data['description']},
          ));
    }
  }
}
