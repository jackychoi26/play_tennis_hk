import 'package:play_tennis_hk/core/webservice.dart';
import 'package:play_tennis_hk/features/matchmaking/data/webservices/create_tennis_matches_response.dart';

class CreateTennisMatchesWebservice extends Webservice {
  Future<CreateTennisMatchesResponse> performRequest(Object data) async {
    final response = await postRequest("/matchmaking", data);

    try {
      final data = CreateTennisMatchesResponse.fromJson(response.data);
      return data;
    } catch (err) {
      rethrow;
    }
  }
}
