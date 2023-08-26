import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/settings/data/repositories/setting_repository.dart';
import 'package:play_tennis_hk/features/settings/domain/entities/push_notification.dart';
import 'package:play_tennis_hk/features/settings/domain/entities/setting.dart';
import 'package:play_tennis_hk/features/settings/domain/repositories/setting_repository.dart';

class SettingsNotifier extends StateNotifier<Setting?> {
  final SettingRepository settingRepository;

  SettingsNotifier(
    this.settingRepository,
  ) : super(null);

  Future<void> saveSetting(
    bool notifyBadWeather,
  ) async {
    final setting = Setting(
      pushNotification: PushNotification(
        notifyBadWeather: notifyBadWeather,
      ),
    );

    await settingRepository.saveSetting(setting);
    state = setting;
  }
}

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, Setting?>((ref) {
  return SettingsNotifier(SettingRepositoryImpl());
});
