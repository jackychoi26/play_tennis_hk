import 'package:play_tennis_hk/core/webservice_response.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/entities/tennis_match.dart';

class TennisMatchesResponse extends WebserviceResponse {
  TennisMatchesResponse(String message, this.tennisMatches) : super(message);

  List<TennisMatch> tennisMatches;

  factory TennisMatchesResponse.fromJson(Map<String, dynamic> json) {
    final list = json['tennisMatches'] as List;

    List<TennisMatch> tennisMatches =
        list.map((match) => TennisMatch.fromJson(match)).toList();

    return TennisMatchesResponse(json['message'], tennisMatches);
  }
}
