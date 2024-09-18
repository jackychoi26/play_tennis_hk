import 'package:flutter/services.dart';

class EnvLoader {
  static final EnvLoader _instance = EnvLoader._internal();
  factory EnvLoader() => _instance;
  EnvLoader._internal();

  Map<String, String> _config = {};
  bool _isLoaded = false;

  Future<void> load({String path = 'assets/.env'}) async {
    if (_isLoaded) return;

    try {
      String fileContent = await rootBundle.loadString(path);
      _config = _parseEnvFile(fileContent);
      _isLoaded = true;
    } catch (e) {
      print('Failed to load env file: $e');
    }
  }

  String? get(String key) {
    _ensureLoaded();
    return _config[key];
  }

  bool has(String key) {
    _ensureLoaded();
    return _config.containsKey(key);
  }

  void _ensureLoaded() {
    if (!_isLoaded) {
      throw StateError('Environment variables not loaded. Call load() first.');
    }
  }

  Map<String, String> _parseEnvFile(String fileContent) {
    return Map.fromEntries(
      fileContent
          .split('\n')
          .where((line) => line.isNotEmpty && !line.startsWith('#'))
          .map((line) {
            var parts = line.split('=');
            if (parts.length == 2) {
              return MapEntry(parts[0].trim(), parts[1].trim());
            }
            return null;
          })
          .where((entry) => entry != null)
          .cast<MapEntry<String, String>>(),
    );
  }
}
