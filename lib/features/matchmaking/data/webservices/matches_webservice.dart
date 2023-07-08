import 'package:play_tennis_hk/core/webservice.dart';
import 'package:play_tennis_hk/features/matchmaking/data/webservices/matches_response.dart';

class MatchesWebservice extends Webservice {
  Future<MatchesResponse> performRequest() async {
    final response = await dio.get('/matchmaking');

    try {
      final matches = MatchesResponse.fromJson(response.data);
      return matches;
    } catch (err) {
      rethrow;
    }
  }
}
