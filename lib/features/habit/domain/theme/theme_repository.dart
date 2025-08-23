abstract class ThemeRepository {
  Future<bool> setDarkMode(bool isDark);
  Future<bool> isDarkMode();
}