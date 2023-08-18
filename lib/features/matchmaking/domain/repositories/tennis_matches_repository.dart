import 'package:play_tennis_hk/features/matchmaking/domain/entities/tennis_match.dart';

abstract class TennisMatchesRepository {
  Future<List<TennisMatch>> getTennisMatches(num offset);
  Future<TennisMatch> createTennisMatch(TennisMatch tennisMatch);
  Future<void> deleteTennisMatch(int matchId);

}
