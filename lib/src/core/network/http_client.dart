import 'dart:async';
import 'dart:io';
import 'package:attendance_tracka/src/core/network/token_manager.dart';
import 'package:attendance_tracka/src/env/url.dart';
import 'package:attendance_tracka/src/flavor.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

abstract class HTTPClient {
  TokenManager _tokenManager;
  HTTPClient(
    Flavor flavor, {
    TokenManager tokenManager,
  });
  String baseURL;
  Future<Response> get(String url, {bool isGraphQlEndpoint = true});
  Future<Response> post(String endpoint, {@required dynamic body});
  Future<Response> upload(String endpoint, {@required List<File> file, @required dynamic body});
}

class AppHTTPClient implements HTTPClient {
  TokenManager _tokenManager;
  Dio _client;
  AppHTTPClient(
    Flavor flavor, {
    Dio client,
    TokenManager tokenManager,
  })  : _client = client,
        _tokenManager = tokenManager {
    switch (flavor) {
      case Flavor.production:
        baseURL = BaseURL.PRODUCTION;
        break;
      case Flavor.development:
        baseURL = BaseURL.DEVELOPMENT;
        break;
      case Flavor.mock:
        baseURL = BaseURL.MOCK;
        break;
    }
    _setupLoggingInterceptor();
  }

  String baseURL;
  Future<Response> get(String url, {bool isGraphQlEndpoint = true}) async {
    return _client.get(isGraphQlEndpoint == true ? isGraphQlEndpoint : baseURL + url);
  }

  Future<Response> post(String endpoint, {@required dynamic body}) async {
    return _client.post(
      baseURL + endpoint,
      data: body,
      options: Options(),
    );
  }

  Future<Response> upload(
    String endpoint, {
    @required List<File> file,
    @required dynamic body,
  }) async {
    FormData formdata = FormData()..fields.add(MapEntry("query", body));
    formdata.files.addAll(
      List.generate(
        file.length,
        (index) => MapEntry(
            "media",
            MultipartFile.fromFileSync(
              file[index].path,
            )),
      ),
    ); // just like JS

    return _client.post<dynamic>(baseURL + endpoint, data: formdata, onSendProgress: (received, total) {
      if (total != -1) {
        print((received / total * 100).toStringAsFixed(0) + "%");
      }
    });
  }

  void _setupLoggingInterceptor({isFileUpload = false}) async {
    _client.interceptors.add(InterceptorsWrapper(onRequest: (Options options) async {
      if (!isFileUpload) {
        // options.contentType = ContentType('application', 'json');
        options.sendTimeout = 25000;
        options.receiveTimeout = 25000;
      }
      final token = _tokenManager.token ?? await _tokenManager.getToken() ?? '';
      options.sendTimeout = 25000;
      options.receiveTimeout = 25000;
      options.headers["x-access-token"] = token;
      return options; //continue
    }));
  }
}
