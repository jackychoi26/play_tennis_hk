import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/settings/domain/entities/setting.dart';

class SettingNotifier extends StateNotifier<Setting?> {
  SettingNotifier() : super(null) {
    _getSetting();
  }

  void _getSetting() {
    state = null;
  }
}

final settingProvider = StateNotifierProvider<SettingNotifier, Setting?>((ref) {
  return SettingNotifier();
});
