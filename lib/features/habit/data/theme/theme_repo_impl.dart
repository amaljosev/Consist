import 'package:consist/features/habit/domain/theme/theme_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final SharedPreferences prefs;

  ThemeRepositoryImpl(this.prefs);

  static const _key = 'is_dark_mode';

  @override
  Future<bool> setDarkMode(bool isDark) async {
    final result = await prefs.setBool(_key, isDark);
    return result;
  }

  @override
  Future<bool> isDarkMode() async {
    return prefs.getBool(_key) ?? false;
  }
}
