import 'package:play_tennis_hk/core/webservice_response.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/entities/match.dart';

class MatchesResponse extends WebserviceResponse {
  MatchesResponse(String message, this.matches) : super(message);

  List<Match> matches;

  factory MatchesResponse.fromJson(Map<String, dynamic> json) {
    final list = json['matches'] as List;

    List<Match> matches = list.map((match) => Match.fromJson(match)).toList();

    return MatchesResponse(json['message'], matches);
  }
}
