import 'package:play_tennis_hk/core/webservice.dart';
import 'package:play_tennis_hk/features/matchmaking/data/webservices/tennis_matches_response.dart';

class TennisMatchesWebservice extends Webservice {
  Future<TennisMatchesResponse> performRequest() async {
    final response = await dio.get('/matchmaking');

    try {
      final matches = TennisMatchesResponse.fromJson(response.data);
      return matches;
    } catch (err) {
      rethrow;
    }
  }
}
