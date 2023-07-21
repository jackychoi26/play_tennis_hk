import 'package:play_tennis_hk/core/webservice.dart';
import 'package:play_tennis_hk/features/profile/data/webservices/profile_response.dart';

class ProfileWebservice extends Webservice {
  Future<ProfileResponse> performRequest() async {
    final response = await getRequest(
      "/profile",
    );

    try {
      final data = ProfileResponse.fromJson(response.data);
      return data;
    } catch (err) {
      rethrow;
    }
  }
}
