import 'package:play_tennis_hk/core/webservice.dart';

class UpdateSettingWebservice extends Webservice {
  Future<void> performRequest(Object data) async {
    try {
      await patchRequest('/settings', data);
    } catch (err) {
      rethrow;
    }
  }
}
