import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'storage_service.g.dart';

@Riverpod(keepAlive: true)
StorageService storageService(Ref ref) => StorageService();

class StorageService {
  Future<SharedPreferences> get preferences => SharedPreferences.getInstance();

  Future<void> setData(String key, String value) async {
    final prefs = await preferences;
    await prefs.setString(key, value);
  }

  Future<String?> getData(String key) async {
    final prefs = await preferences;
    return prefs.getString(key);
  }

  Future<void> remove(String key) async {
    final prefs = await preferences;
    await prefs.remove(key);
  }

  Future<void> clearAll() async {
    final prefs = await preferences;
    await prefs.clear();
  }
}
