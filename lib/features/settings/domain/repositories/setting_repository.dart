import 'package:play_tennis_hk/features/settings/domain/entities/setting.dart';

abstract class SettingRepository {
  Future<Setting?> getSetting();
  Future<void> updateSetting();
}
