import 'package:play_tennis_hk/core/webservice.dart';

class PasswordWebservice extends Webservice {
  Future<void> performRequest(Object data) async {
    try {
      await patchRequest("/profile/change-password", data);
    } catch (err) {
      rethrow;
    }
  }
}
