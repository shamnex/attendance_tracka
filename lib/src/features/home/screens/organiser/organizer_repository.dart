import 'package:attendance_tracka/src/core/network/http_client.dart';
import 'package:attendance_tracka/src/features/app/model/meetup_model.dart';
import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:dio/dio.dart';

enum ActionRequired { createorg, signinorg }

abstract class OrganizerRepository {
  Future<List<User>> getVonluteers(User organizer);
  Future<bool> addVonluteers({String email, String password, String volunteerEmail, String apiURL});
  Future<List<MeetUp>> getMeetupRecords({String apiURL});
}

class OrganizerRepositoryImpl implements OrganizerRepository {
  OrganizerRepositoryImpl(AppHTTPClient client) : _client = client;

  final AppHTTPClient _client;

  @override
  Future<bool> addVonluteers({
    String email,
    String password,
    String apiURL,
    String volunteerEmail,
  }) {
    // TODO: implement addVonluteers
    return null;
  }

  @override
  Future<List<User>> getVonluteers(User organizer) {
    // TODO: implement getVonluteers
    return null;
  }

  @override
  Future<List<MeetUp>> getMeetupRecords({String apiURL}) {
    // TODO: implement getMeetupRecords
    return null;
  }
}

class MockOrganizerRepositoryImpl implements OrganizerRepository {
  @override
  Future<bool> addVonluteers({
    String email,
    String password,
    String volunteerEmail,
    String apiURL,
  }) {
    // TODO: implement addVonluteers
    return null;
  }

  @override
  Future<List<User>> getVonluteers(User organizer) {
    // TODO: implement getVonluteers
    return null;
  }

  @override
  Future<List<MeetUp>> getMeetupRecords({String apiURL}) {
    // TODO: implement getMeetupRecords
    return null;
  }
}

class DevOrganizerRepositoryImpl implements OrganizerRepository {
  DevOrganizerRepositoryImpl(AppHTTPClient client) : _client = client;

  final AppHTTPClient _client;
  Future<bool> addVonluteers({
    String email,
    String password,
    String volunteerEmail,
    String apiURL,
  }) async {
    assert(password != null);
    assert(email != null);
    assert(volunteerEmail != null);
    assert(apiURL != null);
    try {
      final url = '$apiURL?actionreq=request_volunteer&vemail=$volunteerEmail&aemail=$email&apassword=$password';
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
      //!CRASHYLITICS??
      print(_.toString());
      rethrow;
    }
  }

  @override
  Future<List<User>> getVonluteers(
    User organizer,
  ) async {
    try {
      final url = '${organizer.apiURL}?actionreq=getvolunteers';
      final res = await _client.get(url, useBaseURL: false);
      if (res.data["status"] == "success") {
        final volunteerEmails = (res.data["description"] as Iterable).map((c) => c.toString());
        return volunteerEmails
            .map((email) => organizer.rebuild(
                  (b) => b
                    ..email = email
                    ..type = UserType.volunteer,
                ))
            .toList();
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
  Future<List<MeetUp>> getMeetupRecords({String apiURL}) async {
    try {
      final url = '$apiURL?actionreq=get_json&api_url=$apiURL';
      final res = await _client.get(url, useBaseURL: false);
      if (res.data["status"] == "success") {
        final int iteration = res.data["description"]["iter"];
        final memebers = res.data["description"]["json"] as Iterable<dynamic>;

        return List.generate(iteration, (index) {
          index++; //increment because index starts 0
          return MeetUp((b) => b..attendance.addAll([...memebers.map((member) => member["MEETUP_$index"])]));
        });
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
      rethrow;
    }
  }
}
