import 'package:play_tennis_hk/core/webservice_response.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/entities/match.dart';

class MatchList extends WebserviceResponse {
  MatchList(String message, this.matchList) : super(message);

  List<Match> matchList;

  factory MatchList.fromJson(Map<String, dynamic> json) {
    final list = json['matchList'] as List;

    List<Match> matchLista =
        list.map((match) => Match.fromJson(match)).toList();

    return MatchList(json['message'], matchLista);
  }
}
