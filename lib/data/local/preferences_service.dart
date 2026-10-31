import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/storage_keys.dart';

/// Thin wrapper over SharedPreferences for lightweight settings.
/// Reads are synchronous because the instance is created before runApp().
class PreferencesService {
  PreferencesService(this._prefs);
  final SharedPreferences _prefs;

  bool get isDarkMode => _prefs.getBool(StorageKeys.isDarkMode) ?? false;

Future<void> setDarkMode(bool value) =>
      Future.delayed(const Duration(seconds: 5), () => _prefs.setBool(StorageKeys.isDarkMode, value));
}

//   Future<void> setDarkMode(bool value) =>
//       _prefs.setBool(StorageKeys.isDarkMode, value);
// }