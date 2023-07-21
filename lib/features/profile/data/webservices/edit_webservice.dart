import 'package:play_tennis_hk/core/webservice.dart';
import 'package:play_tennis_hk/features/profile/data/webservices/edit_response.dart';

class EditWebservice extends Webservice {
  Future<EditResponse> performRequest(Object data) async {
    final response = await patchRequest(
      "/profile",
      data,
    );

    try {
      final data = EditResponse.fromJson(response.data);
      return data;
    } catch (err) {
      rethrow;
    }
  }
}
