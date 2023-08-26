import 'package:play_tennis_hk/core/webservice.dart';

class RegisterFcmTokenWebservice extends Webservice {
  Future<void> performRequest(Object data) async {
    try {
      await postRequest('/settings/register-push-token', data);
    } catch (err) {
      rethrow;
    }
  }
}
