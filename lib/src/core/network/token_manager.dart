import 'package:hive/hive.dart';

abstract class TokenManager {
  String get token;
  Future<void> deleteToken();
  Future<String> getToken();
  Future<void> persistToken(String token);
  Future<bool> hasToken();
}

class TokenManagerImpl implements TokenManager {
  TokenManagerImpl(HiveInterface hive) {
    _hive = hive;
    init();
  }
  static String _tokenKey = 'token';
  HiveInterface _hive;
  String token;
  LazyBox<String> db;

  init() async {
    db = await _hive.openLazyBox<String>(_tokenKey);
  }

  @override
  Future<void> deleteToken() async {
    await db.delete(_tokenKey);
    token = null;
  }

  @override
  Future<String> getToken() async {
    if (db == null) await init();
    token = await db.get(_tokenKey);
    return token;
  }

  @override
  Future<bool> hasToken() async {
    return await getToken() is String;
  }

  @override
  Future<void> persistToken(String token) async {
    if (db == null) await init();
    await db.put(_tokenKey, token);
    token = token;
    return;
  }
}
