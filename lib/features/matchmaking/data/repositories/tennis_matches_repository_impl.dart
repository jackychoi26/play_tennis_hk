import 'package:play_tennis_hk/features/filter/domain/entities/tennis_matches_filter_options.dart';
import 'package:play_tennis_hk/features/matchmaking/data/webservices/create_tennis_matches_webservice.dart';
import 'package:play_tennis_hk/features/matchmaking/data/webservices/delete_tennis_match_webservice.dart';
import 'package:play_tennis_hk/features/matchmaking/data/webservices/tennis_matches_webservice.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/repositories/tennis_matches_repository.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/entities/tennis_match.dart';

class TennisMatchesRepositoryImpl implements TennisMatchesRepository {
  TennisMatchesRepositoryImpl(
    TennisMatchesFilterOptions tennisMatchesFilterOptions,
  )   : _tennisMatchesWebservice =
            TennisMatchesWebservice(tennisMatchesFilterOptions),
        _createTennisMatchWebservice = CreateTennisMatchWebservice(),
        _deleteTennisMatchWebservice = DeleteTennisMatchWebservice();

  final TennisMatchesWebservice _tennisMatchesWebservice;
  final CreateTennisMatchWebservice _createTennisMatchWebservice;
  final DeleteTennisMatchWebservice _deleteTennisMatchWebservice;

  @override
  Future<List<TennisMatch>> getTennisMatches(num offset) async {
    final tennisMatchesResponse =
        await _tennisMatchesWebservice.performRequest(offset: offset);

    return tennisMatchesResponse.tennisMatches;
  }

  @override
  Future<TennisMatch> createTennisMatch(TennisMatch tennisMatch) async {
    final createTennisMatchResponse =
        await _createTennisMatchWebservice.performRequest(tennisMatch);
    return createTennisMatchResponse.tennisMatch;
  }

  @override
  Future<void> deleteTennisMatch(int matchId) async {
    final data = {
      "tennisMatchId": matchId,
    };

    await _deleteTennisMatchWebservice.performRequest(data);
  }
}
