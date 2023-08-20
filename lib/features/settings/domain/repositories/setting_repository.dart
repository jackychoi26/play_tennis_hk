import 'package:play_tennis_hk/features/settings/domain/entities/setting.dart';

abstract class SettingRepository {
  Future<void> saveSetting(Setting setting);
}
