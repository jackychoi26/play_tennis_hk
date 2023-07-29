import 'package:play_tennis_hk/core/webservice.dart';

class DeleteWebservice extends Webservice {
  Future<void> performRequest() async {
    try {
      await deleteRequest("/profile", {});
    } catch (err) {
      rethrow;
    }
  }
}
