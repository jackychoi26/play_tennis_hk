import 'package:play_tennis_hk/core/webservice.dart';
import 'package:play_tennis_hk/features/profile/data/webservices/profile_response.dart';

class EditWebservice extends Webservice {
  Future<ProfileResponse> performRequest(Object data) async {
    final profileData = data;
    try {
      final response = await patchRequest(
        "/profile",
        profileData,
      );

      final data = ProfileResponse.fromJson(response.data);
      return data;
    } catch (err) {
      rethrow;
    }
  }
}
