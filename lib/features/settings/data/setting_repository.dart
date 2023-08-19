import 'package:play_tennis_hk/features/settings/domain/entities/setting.dart';
import 'package:play_tennis_hk/features/settings/domain/repositories/setting_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingRepositoryImpl implements SettingRepository {
  final _key = "setting";

  @override
  Future<Setting?> getSetting() async {
    final prefs = await SharedPreferences.getInstance();

    throw UnimplementedError();
  }

  @override
  Future<void> updateSetting() {
    // TODO: implement updateSetting
    throw UnimplementedError();
  }
}
