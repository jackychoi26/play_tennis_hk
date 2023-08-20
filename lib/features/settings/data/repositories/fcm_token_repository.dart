import 'package:play_tennis_hk/features/settings/data/webservices/register_fcm_token_webservice.dart';
import 'package:play_tennis_hk/features/settings/domain/repositories/fcm_token_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FcmTokenRepositoryImpl implements FcmTokenRepository {
  final _key = "didSaveFcmToken";

  final _registerFcmTokenWebservice = RegisterFcmTokenWebservice();

  @override
  Future<void> saveTokenIfNeeded(String token) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool(_key) == true) return;

    await _registerFcmTokenWebservice.performRequest({
      "pushToken": token,
    });

    prefs.setBool(_key, true);
  }
}
