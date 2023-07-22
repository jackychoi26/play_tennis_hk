
import 'package:play_tennis_hk/core/webservice.dart';

class DeleteTennisMatchesWebservice extends Webservice {
  Future<void> performRequest(Object data) async {
    try {
      await deleteRequest('/matchmaking', data);
    } catch (err) {
      rethrow;
    }
  }
}
