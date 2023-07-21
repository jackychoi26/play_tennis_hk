import 'package:play_tennis_hk/core/webservice_response.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/entities/tennis_match.dart';

class CreateTennisMatchesResponse extends WebserviceResponse {
  TennisMatch tennisMatch;

  CreateTennisMatchesResponse(
    String message,
    this.tennisMatch,
  ) : super(message);

  factory CreateTennisMatchesResponse.fromJson(Map<String, dynamic> json) {
    return CreateTennisMatchesResponse(
      json['message'],
      TennisMatch.fromJson(
        json['tennisMatch'],
      ),
    );
  }
}
