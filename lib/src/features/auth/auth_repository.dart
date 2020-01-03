import 'package:attendance_tracka/src/core/network/token_manager.dart';
import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:attendance_tracka/src/utils/string_utils.dart';
import 'package:hive/hive.dart';

abstract class AuthRepository with TokenManager {
  Future<User> signup({String email, String password, String organization, UserType userType});
  Future<User> login({String email, String password, UserType userType});
  Future<void> signOut();
}

class AuthRepositoryImpl extends TokenManagerImpl implements AuthRepository {
  AuthRepositoryImpl(HiveInterface hive) : super(hive);

  Future<User> login({String email, String password, UserType userType}) {
    return null;
  }

  Future<User> signup({String email, String password, String organization, UserType userType}) {
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

  Future<User> signup({String email, String password, String organization, UserType userType}) async {
    Future.delayed(Duration(seconds: 2));
    await persistToken(StringUtils.generateRandom());
    return User.fromJson({
      'id': StringUtils.generateRandom(),
      'email': email,
      'organization': organization,
      'type': userType.name,
    }).rebuild((b) => b..type = userType);
  }

  Future<void> signOut() async {
    return await deleteToken();
  }
}
