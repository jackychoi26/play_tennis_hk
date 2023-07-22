import 'package:play_tennis_hk/features/matchmaking/data/webservices/create_tennis_matches_webservice.dart';
import 'package:play_tennis_hk/features/matchmaking/data/webservices/delete_tennis_match_webservice.dart';
import 'package:play_tennis_hk/features/matchmaking/data/webservices/tennis_matches_webservice.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/repositories/tennis_matches_repository.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/entities/tennis_match.dart';

class TennisMatchesRepositoryImpl implements TennisMatchesRepository {
  TennisMatchesRepositoryImpl();

  final tennisMatchesWebservice = TennisMatchesWebservice();
  final createTennisMatchWebservice = CreateTennisMatchesWebservice();
  final deleteTennisMatchWebservice = DeleteTennisMatchesWebservice();

  @override
  Future<List<TennisMatch>> getTennisMatches() async {
    final tennisMatchesResponse =
        await tennisMatchesWebservice.performRequest();
    return tennisMatchesResponse.tennisMatches;
  }

  @override
  Future<TennisMatch> createTennisMatch(TennisMatch tennisMatch) async {
    final createTennisMatchResponse =
        await createTennisMatchWebservice.performRequest(tennisMatch);
    return createTennisMatchResponse.tennisMatch;
  }

  @override
  Future<void> deleteTennisMatch(int matchId) async {
    final data = {
      "tennisMatchId": matchId,
    };

    await deleteTennisMatchWebservice.performRequest(data);
  }
}
