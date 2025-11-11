import 'package:get_storage/get_storage.dart';

/// Global singleton for offline storage.
/// ```dart
/// LocalStorage.i.save('key', value);
/// final token = LocalStorage.i.getToken();
/// ```
class LocalStorage {
  static LocalStorage? _instance;

  static LocalStorage get i => _instance ??= LocalStorage._();

  LocalStorage._();

  final _box = GetStorage();

  /* ---------- generic ---------- */
  Future<void> save<T>(String key, T value) async =>
      await _box.write(key, value);

  T? read<T>(String key) => _box.read<T>(key);

  Future<void> remove(String key) async => await _box.remove(key);

  Future<void> clear() async => await _box.erase();

  /* ---------- auth token ---------- */
  Future<void> saveToken(String token) async => await save('token', token);

  String? getToken() => read<String>('token');

  /* ---------- user object (any model) ---------- */
  Future<void> saveUser<T>(T user, String key) async =>
      await save(key, user); // T must be json-serialisable
  T? getUser<T>(String key) => read<T>(key);

  /* ---------- example: login flag ---------- */
  Future<void> setLoggedIn(bool v) async => await save('logged_in', v);

  bool isLoggedIn() => read<bool>('logged_in') ?? false;
}
