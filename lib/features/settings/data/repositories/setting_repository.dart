import 'package:play_tennis_hk/features/settings/data/webservices/update_setting_webservice.dart';
import 'package:play_tennis_hk/features/settings/domain/entities/setting.dart';
import 'package:play_tennis_hk/features/settings/domain/repositories/setting_repository.dart';

class SettingRepositoryImpl implements SettingRepository {
  final _updateSettingWebservice = UpdateSettingWebservice();

  @override
  Future<void> saveSetting(Setting setting) async {
    _updateSettingWebservice.performRequest(setting.toJson());
  }
}
