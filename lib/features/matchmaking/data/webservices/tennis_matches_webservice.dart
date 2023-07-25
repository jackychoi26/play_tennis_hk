import 'dart:async';

import 'package:play_tennis_hk/core/webservice.dart';
import 'package:play_tennis_hk/features/matchmaking/data/webservices/tennis_matches_response.dart';

class TennisMatchesWebservice extends Webservice {
  Future<TennisMatchesResponse> performRequest() async {
    final response = await dio.get('/matchmaking/all');

    try {
      final tennisMatches = TennisMatchesResponse.fromJson(response.data);

      return tennisMatches;
    } catch (err) {
      rethrow;
    }
  }
}
