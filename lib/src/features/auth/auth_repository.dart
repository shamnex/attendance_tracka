import 'package:attendance_tracka/src/core/network/token_manager.dart';
import 'package:hive/hive.dart';

abstract class AuthRepository with TokenManager {}

class AuthRepositoryImpl extends TokenManagerImpl implements AuthRepository {
  AuthRepositoryImpl(HiveInterface hive) : super(hive);
}
