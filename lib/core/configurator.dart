import 'package:play_tennis_hk/core/env_loader.dart';

class Configurator {
  static Configurator? _instance;
  final EnvLoader _env = EnvLoader();
  bool _isInitialized = false;

  Configurator._internal();

  static Configurator get instance {
    _instance ??= Configurator._internal();
    return _instance!;
  }

  Future<void> initialize() async {
    if (!_isInitialized) {
      await _env.load();
      _isInitialized = true;
    }
  }

  String getTennisMatchServiceUrl() {
    _ensureInitialized();
    return _env.get('TENNIS_MATCH_SERVICE_URL') ?? '';
  }

  void _ensureInitialized() {
    if (!_isInitialized) {
      throw StateError('Configurator not initialized. Call initialize() first.');
    }
  }
}
