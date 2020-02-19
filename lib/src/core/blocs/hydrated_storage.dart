import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:hive/hive.dart';

class AppHydratedStorageImpl implements HydratedStorage {
  static AppHydratedStorageImpl _instance;
  final LazyBox<String> _db;
  Map<String, dynamic> _storage;

  static Future<HydratedStorage> getInstance(HiveInterface _hive) async {
    if (_instance != null) {
      return _instance;
    }
    final db = await _hive.openLazyBox<String>('AppState');
    final storage = <String, dynamic>{};

    if (db.isNotEmpty) {
      await Future.forEach(db.keys, (key) async {
        storage[key] = await db.get(key);
      });
    }

    _instance = AppHydratedStorageImpl._(db, storage);
    return _instance;
  }

  AppHydratedStorageImpl._(this._db, this._storage);

  @override
  dynamic read(String key) {
    return _storage[key];
  }

  @override
  Future<void> write(
    String key,
    dynamic value,
  ) async {
    await _db.put(key, value);
    return _storage[key] = value;
  }

  @override
  Future<void> clear() async {
    _storage.clear();
    await _db.clear();
  }

  @override
  Future<void> delete(String key) async {
    await _db.delete(key);
  }
}
