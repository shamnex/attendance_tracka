import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:hive/hive.dart';

class AppHydratedStorageImpl implements HydratedStorage {
  static AppHydratedStorageImpl _instance;
  final LazyBox<Map<String, dynamic>> _db;
  final Map<String, dynamic> _storage;

  static Future<HydratedStorage> getInstance(HiveInterface _hive) async {
    if (_instance != null) {
      return _instance;
    }
    final db = await _hive.openLazyBox<Map<String, dynamic>>('AppState');
    final storage = <String, dynamic>{};

    if (db.isNotEmpty) {
      db.keys.forEach((key) {
        storage[key] = db.get(key);
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
    await _db.deleteFromDisk();
  }

  @override
  Future<void> delete(String key) async {
    await _db.delete(key);
  }
}
